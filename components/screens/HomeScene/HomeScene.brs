function Init()
  m.reg = CreateObject("roRegistry")
  m.rSections = m.reg.GetSectionList()

  MakeDialog()
end function

sub ClearRegistry(sectionList)
  for each section in sectionList
    regS = CreateObject("roRegistrySection", section)
    secsA = regS.GetKeyList()
    for each key in secsA
      regS.Delete(key)
      ?"Deleting ";key;" from ";section
    end for
  end for
end sub

sub MakeDialog()
  dialog = CreateObject("roSGNode", "Dialog")
  dialog.message = "Clear registry section:"
  dialog.buttons = ["All"]
  m.buttonMap = [ 0 ]

  for each sectionName in m.rSections
    dialog.buttonGroup.createChild("Button")
    currNum = dialog.buttonGroup.getChildCount() - 1
    dialog.buttonGroup.getChild(currNum).text = sectionName
    m.buttonMap.Append([ currNum ])
  end for

  m.top.dialog = dialog

  m.top.dialog.observeField("buttonSelected", "PressButton")
end sub

sub PressButton()
  if m.top.dialog.buttonSelected = 0
    ClearRegistry(m.rSections)
    buttonCount = m.top.dialog.buttonGroup.GetChildCount() - 2
    for count = 0 to buttonCount
      m.top.dialog.buttonGroup.removeChildIndex(1)
    end for
  else
    ClearRegistry([m.top.dialog.buttonGroup.GetChild(m.buttonMap[m.top.dialog.buttonSelected]).text])
    m.top.dialog.buttonGroup.removeChildIndex(m.buttonMap[m.top.dialog.buttonSelected])
    for count = m.top.dialog.buttonSelected + 1 to m.buttonMap.Count() - 1
      m.buttonMap[count]--
    end for
  end if

  m.top.dialog.buttonGroup.focusButton = 0
end sub
