function Init()
  'Registry from which we pull list of existing registry sections.
  m.reg = CreateObject("roRegistry")
  m.rSections = m.reg.GetSectionList()

  'Open initial dialog with options
  MakeDialog()
end function

'Clear all registry entries from a list of registry sections
sub ClearRegistry(sectionList)
  for each section in sectionList
    'For each reg section in the list, get a list of the existing entries
    regS = CreateObject("roRegistrySection", section)
    secsA = regS.GetKeyList()
    for each key in secsA
      'And delete them
      regS.Delete(key)
      ?"Deleting ";key;" from ";section
    end for
  end for
end sub

'Create dialog which lists all registry sections and gives the option to delete them.
sub MakeDialog()
  dialog = CreateObject("roSGNode", "Dialog")
  dialog.message = "Clear registry section:"
  'Start with just "all" button (currently it still says "all" even if there are no extant sections)
  dialog.buttons = ["All"]
  'Because deleting a button updates the buttonGroup indices but not the number returned by
  'dialog.buttonSelected, this buttonMap list will be a way to enter the buttonSelected
  'number and get the current position of that button in the buttonGroup list.
  m.buttonMap = [ 0 ]

  'For each registry section add a button with that name, and add an entry to the buttonMap
  for each sectionName in m.rSections
    dialog.buttonGroup.createChild("Button")
    currNum = dialog.buttonGroup.getChildCount() - 1
    dialog.buttonGroup.getChild(currNum).text = sectionName
    m.buttonMap.Append([ currNum ])
  end for

  'Now that all the buttons are on there, make it show up.
  m.top.dialog = dialog

  m.top.dialog.observeField("buttonSelected", "PressButton")
end sub

sub PressButton()
  'If the user selected "all" delete everything from the list of registry sections
  if m.top.dialog.buttonSelected = 0
    ClearRegistry(m.rSections)
    buttonCount = m.top.dialog.buttonGroup.GetChildCount() - 2
    '...and delete the relevant buttons as well.
    for count = 0 to buttonCount
      m.top.dialog.buttonGroup.removeChildIndex(1)
    end for
  else
    'If the user selected something else, use the buttonMap list to see what the number
    'matches up to in the buttonGroup list, delete that registry section
    ClearRegistry([m.top.dialog.buttonGroup.GetChild(m.buttonMap[m.top.dialog.buttonSelected]).text])
    'and then delete that button as well.
    m.top.dialog.buttonGroup.removeChildIndex(m.buttonMap[m.top.dialog.buttonSelected])
    'then update the buttonMap so that it will still be accurate.
    for count = m.top.dialog.buttonSelected + 1 to m.buttonMap.Count() - 1
      m.buttonMap[count]--
    end for
  end if

  'since we delete the button which had focus, we need to give focus to another button.
  m.top.dialog.buttonGroup.focusButton = 0
end sub
