outputimagemodule = {name: "outputimagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["outputimagemodule"]?  then console.log "[outputimagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
canvasWidth = 500
canvasHeight = 500

############################################################
canvas = null
context = null

############################################################
outputimagemodule.initialize = () ->
    log "outputimagemodule.initialize"
    canvas = document.getElementById("outputimage")
    canvas.width = canvasWidth
    canvas.height = canvasHeight
    context = canvas.getContext("2d")
    return

############################################################
outputimagemodule.putImage = (matrix) ->
    array = new Uint8ClampedArray(matrix.data, matrix.cols, matrix.rows)
    imageData = new ImageData(array)

    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.putImageData(imageData, 0, 0)
    return

outputimagemodule.putImageData = (imageData) ->
    context.clearRect(0,0,canvasWidth, canvasHeight)
    context.putImageData(imageData, 0, 0)
    return

outputimagemodule.showMatrix = (matrix) ->
    cv.imshow(canvas, matrix)
    return

module.exports = outputimagemodule