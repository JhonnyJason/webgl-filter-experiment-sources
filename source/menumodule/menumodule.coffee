menumodule = {name: "menumodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["menumodule"]?  then console.log "[menumodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
source = null
imageSelect = null
filterSettings = null

############################################################
#region HTMLElements
# goIcon = null
imageIcon = null
camIcon = null
filterSettingsIcon = null
#endregion

############################################################
activeSource = ""
activeFilterSettings = false

############################################################
menumodule.initialize = () ->
    log "menumodule.initialize"
    source = allModules.sourceimagemodule
    imageSelect = allModules.imageselectmodule
    filterSettings = allModules.filtersettingsmodule

    camIcon = document.getElementById("cam-icon")
    imageIcon = document.getElementById("image-icon")
    filterSettingsIcon = document.getElementById("filter-settings-icon")

    camIcon.addEventListener("click", camIconClicked)
    imageIcon.addEventListener("click", imageIconClicked)
    filterSettingsIcon.addEventListener("click", filterSettingsIconClicked)

    imageIcon.classList.add("active")
    return
    
############################################################
setActiveSource = (label) ->
    log "setActiveSource"
    imageSelect.setMode(label)
    if label == "image"
        return if activeSource == "image"
        source.setImageAsSource()
        camIcon.classList.remove("active")
        imageIcon.classList.add("active")
        activeSource = "image"
        return
    if label == "cam"
        return if activeSource == "cam"
        source.setCamAsSource()
        imageIcon.classList.remove("active")
        camIcon.classList.add("active")
        activeSource = "cam"
        return
    return

############################################################
camIconClicked = ->
    log "camIconClicked"
    setActiveSource("cam")
    return

imageIconClicked = ->
    log "imageIconClicked"
    setActiveSource("image")
    return

filterSettingsIconClicked = ->
    log "filterSettingsIconClicked"
    if activeFilterSettings == true
        filterSettings.setActive(false)
        filterSettingsIcon.classList.remove("active")
        activeFilterSettings = false
        return
    if activeFilterSettings == false
        filterSettings.setActive(true)
        filterSettingsIcon.classList.add("active")
        activeFilterSettings = true    
        return
    return

module.exports = menumodule