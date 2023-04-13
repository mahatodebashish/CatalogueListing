sub checkNetworkConnectivity()
    isNetworkConnected = hasConnectivity()
    if isNetworkConnected = false
        showNetworkErrorDialog()
    end if
    while not isNetworkConnected
        showNetworkErrorDialog()
        isNetworkConnected = hasConnectivity()
    end while
end sub

sub hasConnectivity() as Boolean
    info = createObject("roDeviceInfo")
    return info.GetLinkStatus() 
end sub


function showNetworkErrorDialog()
    m.networkErrorDialog = createObject("roSGNode", "Dialog")
    m.networkErrorDialog.title = "No Network Detected.."
    m.networkErrorDialog.optionsDialog = false
    m.networkErrorDialog.message = "Please make sure that your Roku Player is connected to the Internet"
    m.networkErrorDialog.buttons = ["Reload"]
    m.networkErrorDialog.observeField("buttonSelected", "onNetworkErrorDialogCallback")
    m.sceneNode = getSceneNode()
    m.sceneNode.dialog = m.networkErrorDialog

end function



function getSceneNode()
	nxt = m.top
	scene = nxt
	while nxt <> invalid
	  scene = nxt
	  nxt = scene.getParent()
	end while
	return scene
end function