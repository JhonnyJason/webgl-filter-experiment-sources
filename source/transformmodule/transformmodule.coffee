transformmodule = {name: "transformmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["transformmodule"]?  then console.log "[transformmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
# cv = require "./opencv"

# opencv = require "./opencv"
# cv = opencv()

############################################################
source = null
output = null

runtimeInitialized = false
actorWaiting = false

############################################################
transformmodule.initialize = () ->
    log "transformmodule.initialize"
    source = allModules.sourceimagemodule
    output = allModules.outputimagemodule
    cv["onRuntimeInitialized"] = runtimeHasInitialized
    return

runtimeHasInitialized = ->
    log "runtimeHasInitialized"
    runtimeInitialized = true
    if actorWaiting then transformmodule.act()
    actorWaiting = false
    return

imageChanged = (e) ->
    console.log("image changed")
    imgElement.src = URL.createObjectURL(e.target.files[0])    
    return

imageLoaded = ->
    console.log("image loaded")
    mat = cv.imread(imgElement)
    greyMat = mat.rgbaToGray()
    console.log greyMat
    cv.imshow("outputCanvas", greyMat)
    return

############################################################
transformmodule.act = ->
    log "transformmodule.act"
    if !runtimeInitialized 
        actorWaiting = true
        return

    # imageData = source.getImageData()
    # log imageData
    # sourceMat = cv.matFromImageData(imageData)
    # log sourceMat

    # sample code from youtube
    mat = source.getImageMatrix()
    cv.cvtColor(mat, mat, cv.COLOR_RGB2GRAY)
    output.showMatrix(mat)
    mat.delete()


    # destMat = new cv.Mat()

    # scale and shift are used to map the data to [0, 255].
    # sourceMat.convertTo(destMat, cv.CV_8U, 1, 0)
    # *** is GRAY, RGB, or RGBA, according to src.channels() is 1, 3 or 4.
    # cv.cvtColor(destMat, destMat, cv.COLOR_GRAY2RGBA)

    # output.putImage(detMat)
    # array = new Uint8ClampedArray(destMat.data, destMat.cols, destMat.rows)
    # transformedImageData = new ImageData(array)
    
    # output.putimageData(transformedImageData)



    # imgElement = document.getElementById("imageSrc")
    # inputElement = document.getElementById("fileInput")
    # imageLoaded()
    # inputElement.addEventListener("change", imageChanged, false)
    # imgElement.onload = imageLoaded

    return

module.exports = transformmodule