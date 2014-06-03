/**
 * Global Settings
 */
var mash = ['alt', 'cmd', 'ctrl'];
var mashShift = ['alt', 'cmd', 'ctrl', 'shift'];

var mousePositions = {};
var lastFrames = {};
var padding = 0;

// global function

var alertTitle = function(window) { api.alert(window.title());};

function save_mouse_position_for_now() {
  if (Window.focusedWindow() === undefined) {
    return;
  }
  mousePositions[Window.focusedWindow().title()] = MousePosition.capture();
}

function restore_mouse_position_for_now() {
  if (Window.focusedWindow() === undefined) {
    return;
  }
  if (mousePositions[Window.focusedWindow().title()]  !== undefined) {
    MousePosition.restore(mousePositions[Window.focusedWindow().title()]);
  }
}

// Move windows between monitors

function moveToScreen(win, screen) {
  if (!screen) {
    return;
  }

  var frame = win.frame();
  var oldScreenRect = win.screen().frameWithoutDockOrMenu();
  var newScreenRect = screen.frameWithoutDockOrMenu();

  var xRatio = newScreenRect.width / oldScreenRect.width;
  var yRatio = newScreenRect.height / oldScreenRect.height;

  win.setFrame({
    x: (Math.round(frame.x - oldScreenRect.x) * xRatio) + newScreenRect.x,
    y: (Math.round(frame.y - oldScreenRect.y) * yRatio) + newScreenRect.y,
    width: Math.round(frame.width * xRatio),
    height: Math.round(frame.height * yRatio)
  });
}

function circularLookup(array, index) {
  if (index < 0)
    return array[array.length + (index % array.length)];
  return array[index % array.length];
}

function rotateMonitors(offset) {
  var win = Window.focusedWindow();
  var currentScreen = win.screen();
  var screens = [currentScreen];
  for (var x = currentScreen.previousScreen(); x != win.screen(); x = x.previousScreen()) {
    screens.push(x);
  }

  screens = _(screens).sortBy(function(s) { return s.frameWithoutDockOrMenu().x; });
  var currentIndex = _(screens).indexOf(currentScreen);
  moveToScreen(win, circularLookup(screens, currentIndex + offset));
}

function leftOneMonitor() {
  rotateMonitors(-1);
}

function rightOneMonitor() {
  rotateMonitors(1);
}


function switchApp(appName) {
  //switch app, and remember mouse position
  save_mouse_position_for_now();
  api.launch(appName);
  restore_mouse_position_for_now();
}

// Start/select apps
App.allWithTitle = function( title ) {
  return _(this.runningApps()).filter( function( app ) {
    if (app.title() === title) {
      return true;
    }
  });
};


App.focusOrStart = function ( title ) {
  var apps = App.allWithTitle( title );
  if (_.isEmpty(apps)) {
    api.alert(rageOfDongers + " Starting " + title);
    api.launch(title);
    return;
  }

  var windows = _.chain(apps)
    .map(function(x) { return x.allWindows(); })
    .flatten()
    .value();

  activeWindows = _(windows).reject(function(win) { return win.isWindowMinimized();});
  if (_.isEmpty(activeWindows)) {
    api.alert(whyLook +" All windows minimized for " + title);
    return;
  }

  activeWindows.forEach(function(win) {
    win.focusWindow();
  });
};

App.byTitle = function(title) {
  var apps = this.runningApps();

  for (i = 0; i < apps.length; i++) {
    var app = apps[i];
    if (app.title() == title) {
      app.show();
      return app;
    }
  }
};

App.prototype.firstWindow = function() {
  return this.visibleWindows()[0];
};

function forApp(name, f) {
  var app = App.byTitle(name);

  if (app) {
    _.each(app.visibleWindows(), f);
  }
}

Window.prototype.calculateGrid = function(x, y, width, height) {
  var screen = this.screen().frameWithoutDockOrMenu();

  return {
    x:      Math.round(x * screen.width)       + padding    + screen.x,
    y:      Math.round(y * screen.height)      + padding    + screen.y,
    width:  Math.round(width * screen.width)   - 2*padding,
    height: Math.round(height * screen.height) - 2*padding
  };
};

Window.prototype.toGrid = function(x, y, width, height) {
  var rect = this.calculateGrid(x, y, width, height);
  this.setFrame(rect);
  return this;
};

Window.prototype.toFullScreen = function() {
  return this.toGrid(0, 0, 1, 1);
};

Window.prototype.toTopHalf = function() {
  return this.toGrid(0, 0, 1, 0.5);
};

Window.prototype.toBottomHalf = function() {
  return this.toGrid(0, 0.5, 1, 0.5);
};

Window.prototype.toLeftHalf = function() {
  return this.toGrid(0, 0, 0.5, 1);
};

Window.prototype.toRightHalf = function() {
  return this.toGrid(0.5, 0, 0.5, 1);
};

Window.prototype.rememberFrame = function() {
  lastFrames[this] = this.frame();
};

Window.prototype.forgetFrame = function() {
  delete lastFrames[this];
};

Window.prototype.moveToScreen = function(screen) {
  if (!screen) {
    return;
  }

  var frame = this.frame();
  var oldScreenRect = this.screen().frameWithoutDockOrMenu();
  var newScreenRect = screen.frameWithoutDockOrMenu();
  var xRatio = newScreenRect.width / oldScreenRect.width;
  var yRatio = newScreenRect.height / oldScreenRect.height;

  this.setFrame({
    x: (Math.round(frame.x - oldScreenRect.x) * xRatio) + newScreenRect.x,
    y: (Math.round(frame.y - oldScreenRect.y) * yRatio) + newScreenRect.y,
    width: Math.round(frame.width * xRatio),
    height: Math.round(frame.height * yRatio)
  });
};


Window.prototype.windowsOnOtherScreen = function() {
  var otherWindowTitlesOnSameScreen = _.map( Window.focusedWindow().otherWindowsOnSameScreen(), function(w) { return w.title(); });
  return _.chain(Window.focusedWindow().otherWindowsOnAllScreens())
    .filter(function(window) { return ! _.contains(otherWindowTitlesOnSameScreen, window.title()); })
    .value();
};

Window.prototype.sortByMostRecent = function(windows) {
  var visibleWindowsMostRecentFirst = _.map(Window.visibleWindowsMostRecentFirst(), function(w) { return w.title();});
  var weights = _.range(visibleWindowsMostRecentFirst.length, 0, -1);
  var visibleWindowsMostRecentFirstWithWeight = _.zip(visibleWindowsMostRecentFirst, weights);

  return _.chain(windows)
    .sortBy(function(window) { return visibleWindowsMostRecentFirstWithWeight[window.title()]; })
    .value();
};


Window.prototype.focusNextWindowsOnSameScreen = function() {
  var currentWindow = Window.focusedWindow();
  var windows = currentWindow.otherWindowsOnSameScreen();
  windows.push(currentWindow);
  windows = _.chain(windows).sortBy(function(window) { return window.app().pid;}).value();
  windows[(_.indexOf(windows, currentWindow) + 1) % windows.length].focusWindow();
};


Window.prototype.focusNextScreen = function() {
  var windows = this.sortByMostRecent(this.windowsOnOtherScreen());
  if (windows.length > 0) {
    windows[0].focusWindow();
  }
};


Window.prototype.focusPreviousWindowsOnSameScreen = function() {
  var currentWindow = Window.focusedWindow();
  var windows = currentWindow.otherWindowsOnSameScreen();
  windows.push(currentWindow);
  windows = _.chain(windows).sortBy(function(window) { return window.app().pid;}).value();
  windows[(_.indexOf(windows, currentWindow) - 1 + windows.length) % windows.length].focusWindow();
};

// Key bindings

api.bind('[', mash, leftOneMonitor);
api.bind(']', mash, rightOneMonitor);

api.bind('.', mash, function() {
  Window.focusedWindow().toFullScreen();
});

api.bind('up', mash, function() {
  Window.focusedWindow().toTopHalf();
});

api.bind('down', mash, function() {
  Window.focusedWindow().toBottomHalf();
});

api.bind('left', mash, function() {
  Window.focusedWindow().toLeftHalf();
});

api.bind('right', mash, function() {
  Window.focusedWindow().toRightHalf();
});

api.bind('1', mash, function() {
  api.alert("Layout 1", 0.5);
  forApp("Google Chrome", function(win) {
    win.toFullScreen();
  });

  forApp("iTerm", function(win) {
    win.toFullScreen();
  });

  forApp("Sublime Text", function(win) {
    win.toFullScreen();
  });

  forApp("Atom", function(win) {
    win.toFullScreen();
  });

  forApp("Messages", function(win) {
    win.toGrid(0.2, 0.2, 0.6, 0.6);
  });
});

api.bind('2', mash, function() {
  api.alert("Layout 2", 0.5);

  forApp("Terminal", function(win) {
    win.toRightHalf();
  });

  forApp("Sublime Text", function(win) {
    win.toLeftHalf();
  });

  forApp("Atom", function(win) {
    win.toLeftHalf();
  });
});

// // Launch App
// api.bind('`', mash, function() {
//   switchApp('iTerm');
// });
// api.bind('1', mash, function() { switchApp('Firefox'); });
// api.bind('2', mash, function() { switchApp('Google Chrome'); });
// api.bind('3', mash, function() { switchApp('QQ'); });
// api.bind('a', mash, function() {
//   switchApp('MacVim');
// });
// api.bind('s', mash, function() { switchApp('IntelliJ IDEA 13'); });
// api.bind(',', mash, function() { switchApp('Sparrow'); });
// api.bind('.', mash, function() { switchApp('Evernote'); });
// api.bind('/', mash, function() { switchApp('Finder'); });

// Multi screen
api.bind('l', mash, function() {
  Window.focusedWindow().focusWindowRight();
});
api.bind('h', mash, function() {
  Window.focusedWindow().focusWindowLeft();
});
api.bind('l', mashShift, function() {
  Window.focusedWindow().moveToScreen(Window.focusedWindow().screen().nextScreen());
});
api.bind('h', mashShift, function() {
  Window.focusedWindow().moveToScreen(Window.focusedWindow().screen().previousScreen());
});

// Window
api.bind('m', mash, function() {
  Window.focusedWindow().maximize();
});

api.bind('j', mash, function() {
  var window = Window.focusedWindow();
  if (window === undefined) {
    Window.visibleWindowsMostRecentFirst()[0].focusWindow();
    return;
  }
  window.focusNextWindowsOnSameScreen();
});
api.bind('k', mash, function() {
  var window = Window.focusedWindow();
  if (window === undefined) {
    Window.visibleWindowsMostRecentFirst()[0].focusWindow();
    return;
  }
  window.focusPreviousWindowsOnSameScreen();
});


api.bind('0', mash, function() {
  var cw = Window.focusedWindow();
  //_.map(App.runningApps(), function(app) { api.alert(app.title(), 5)});
  //_.map([Window.focusedWindow()], function(window) { api.alert(window.title())});  // current one
  //_.map(Window.allWindows(), function(window) { api.alert(window.title(), 5)});  // all, include hide
  //_.map(Window.visibleWindows(), function(window) { api.alert(window.title())});  // all, no hide
  //_.map(Window.visibleWindowsMostRecentFirst(), function(window) { api.alert(window.title())});
  //_.map(Window.focusedWindow().otherWindowsOnSameScreen(), alert_title);
  //_.map(Window.focusedWindow().otherWindowsOnAllScreens(), function(window) { api.alert(window.title())});  // no space
  //_.map(Window.focusedWindow().windowsOnOtherScreen(), alert_title);
  _.map(cw.sortByMostRecent(cw.windowsOnOtherScreen()), alert_title);


  //_.chain(Window.allWindows()).difference(Window.visibleWindows()).map(function(window) { api.alert(window.title())});  // all, include hide
  //api.alert(_.chain(Window.allWindows()).difference(Window.visibleWindows()).value().length);
  //api.alert(_.chain(Window.allWindows()).value().length);
});

// Mission Control
// use Mac Keyboard setting
// mash + i
// mash + o
