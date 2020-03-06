sourceimagemodule = {name: "sourceimagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["sourceimagemodule"]?  then console.log "[sourceimagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

canvasWidth = 500
canvasHeight = 500

############################################################
canvas = null
context = null
image = null

############################################################
sourceimagemodule.initialize = () ->
    log "sourceimagemodule.initialize"
    canvas = document.getElementById("sourceimage")
    image = document.getElementById("hidden-source-image")
    canvas.width = canvasWidth
    canvas.height = canvasHeight
    context = canvas.getContext("2d");
    context.drawImage(image, 0, 0)
    # context.drawImage(image, 7, 35, 290, 66);
    return
    
############################################################
sourceimagemodule.getImageData = -> 
    return context.getImageData(0,0, canvasWidth, canvasHeight)

sourceimagemodule.getImageMatrix = ->
    return cv.imread(image)

module.exports = sourceimagemodule