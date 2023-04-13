Sub init()
    m.RowList = m.top.findNode("RowList")
    m.Description = m.top.findNode("Description")
    m.Poster = m.top.findNode("Poster")
    m.timer = m.top.findNode("timer")
    m.timer.control = "start"
    m.Timer.observeField("fire", "apiresponsetime")

    showdialog()

    if( hasConnectivity() )
        
        callHomePageApi() 
       
    else

        showNetworkErrorDialog()
    end if
  
End Sub

function apiresponsetime()

        if (m.RowList.hasFocus()=false)
            dismissdialog()
            showNetworkErrorDialog()
            m.timer.control = "stop"
        end if
    end function

sub dismissdialog()
    m.top.dialog.close = true
  end sub

sub showdialog()
    progressdialog = createObject("roSGNode", "ProgressDialog")
    progressdialog.title = "Loading.."
    m.top.dialog = progressdialog
  end sub

function callHomePageApi()
m.LoadTask = CreateObject("roSGNode", "HomeTask") 
m.LoadTask.observeField("content","rowListContentChanged")
 m.LoadTask.control = "RUN"
 end function

Sub rowListContentChanged()
     m.RowList.content = m.LoadTask.content
     m.RowList.setFocus(true)

     dismissdialog()
    
end Sub


function onNetworkErrorDialogCallback()

    'dismissdialog()

    selectedIndex = m.networkErrorDialog.buttonSelected

    m.timer.control = "start"
    if( hasConnectivity())


        showdialog()
        callHomePageApi()
        m.networkErrorDialog.close = true

   

 end if

   
end function





  