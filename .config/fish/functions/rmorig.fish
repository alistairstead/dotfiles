# Remove latent .orig files
function rmorig -d 'Remove any files below a specified path that match *.orig'
    rm -rf ./*.orig ./**/*.orig
end

