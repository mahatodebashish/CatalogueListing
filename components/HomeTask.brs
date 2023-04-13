Sub Init()
    m.top.functionName = "loadContent"
End Sub







Sub loadContent()

    
 
    list = GetContentFeed()
    
    
    featuredArrayy = []   

   if list.Count()<>0

    for i = 0 to list.count()-1
         aa1 = CreateObject("roAssociativeArray")  
      aa1 = list[i]
         
     temp1 = CreateObject("roAssociativeArray")  
     temp1.TITLE = aa1.category

     print  "rowTitle=" ;   temp1.TITLE
     temp1.listArray = aa1.contentarray
     
     
     
     featuredArrayy.push(temp1)

    end for

     m.global.featuredArray=featuredArrayy


    
    m.top.content = ParseXMLContent(m.global.featuredArray)

else


end if
  

End Sub

function GetContentFeed()

    
url = CreateObject("roUrlTransfer")
url.SetUrl("https://storage.googleapis.com/android-tv/android_tv_videos_new.json")

url.SetCertificatesFile("common:/certs/ca-bundle.crt")
url.EnableEncodings(true)
url.AddHeader("Expect","")


rsp = url.GetToString()


    
if rsp.len() <> 0

json = ParseJSON(rsp)

result = []

for each xmlItem in json.googlevideos
       
    menuItem = {}
    menuItem.category = xmlItem.category
    menuItem.contentarray=xmlItem.videos
                         
                 
                            
    if (menuItem.contentarray.Count()>0)
            
            result.push(menuItem)

    end if			


               
            
end for

return result

else

    print "102"

endif

return result



end function



Function ParseXMLContent(list As Object)

  

    RowItems = createObject("RoSGNode","ContentNode")
    
	

    for each rowAA in list
    'for index = 0 to 1
        row = createObject("RoSGNode","ContentNode")
		

        row.Title = rowAA.Title

		
        for each itemAA in rowAA.listArray
		
		
            item = createObject("RoSGNode","ContentNode")
            ' We don't use item.setFields(itemAA) as doesn't cast streamFormat to proper value
            for each key in itemAA
                
               
                 item.HDPosterUrl = itemAA.card						
                 item.Title = itemAA.title
                
				   
				
            end for
            row.appendChild(item)
        end for
        RowItems.appendChild(row)
    end for

    return RowItems
End Function