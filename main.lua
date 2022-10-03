function initUi()


  app.registerUi({["menu"] = "Changing palette", ["callback"] = "change_color_layout", ["accelerator"] = "<Ctrl>0"});

  app.registerUi({["menu"] = "Selecting tool", ["callback"] = "erase", ["accelerator"] = "KP_0"});
  app.registerUi({["menu"] = "Selecting tool", ["callback"] = "pen", ["accelerator"] = "KP_1"});
  app.registerUi({["menu"] = "Selecting tool", ["callback"] = "highlight", ["accelerator"] = "KP_2"});
  app.registerUi({["menu"] = "Selecting tool", ["callback"] = "text", ["accelerator"] = "KP_3"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "white", ["accelerator"] = "KP_4"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "red", ["accelerator"] = "KP_5"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "green", ["accelerator"] = "KP_6"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "rect", ["accelerator"] = "KP_7"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "circle", ["accelerator"] = "KP_8"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "arrow", ["accelerator"] = "KP_9"});

  app.registerUi({["menu"] = "Selecting tool", ["callback"] = "erase_mod", ["accelerator"] = "<Ctrl>KP_0"});
  app.registerUi({["menu"] = "Selecting tool", ["callback"] = "pen_dash", ["accelerator"] = "<Ctrl>KP_1"});
  app.registerUi({["menu"] = "Selecting tool", ["callback"] = "pen_dot", ["accelerator"] = "<Ctrl>KP_2"});
  app.registerUi({["menu"] = "Selecting tool", ["callback"] = "pen_dash_dot", ["accelerator"] = "<Ctrl>KP_3"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "yellow", ["accelerator"] = "<Ctrl>KP_4"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "blue", ["accelerator"] = "<Ctrl>KP_5"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "purple", ["accelerator"] = "<Ctrl>KP_6"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "select_arrow", ["accelerator"] = "<Ctrl>KP_7"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "select_rect", ["accelerator"] = "<Ctrl>KP_8"});
  app.registerUi({["menu"] = "Changing color", ["callback"] = "select_area", ["accelerator"] = "<Ctrl>KP_9"});
end

local tools = {
    "ERASER",
    "PEN",
    "HIGHLIGHTER",
    "TEXT",
    "DELETE_STROKE",
}

local style_of_lines = {
    "PLAIN",
    "DASH",
    "DOT"
}

local shape_list = {
    "TOOL_SELECT_OBJECT", 
    "TOOL_SELECT_RECT",
    "TOOL_SELECT_REGION", 
    "TOOL_DRAW_ARROW",
    "TOOL_DRAW_RECT",
    "TOOL_DRAW_ELLIPSE",
}


local standard_palette = { 
  {"Name", "Standard"},
  {"black", 0x000000},  
  {"red", 0xff0000},        
  {"green", 0x008000},
  {"yellow", 0xffff00},    
  {"blue", 0x3333cc},      
  {"magenta", 0xff00ff},
}

local gruvbox_palette = { 
  {"Name", "gruvbox_palette"},
  {"white", 0xebdbb2},
  {"red", 0xcc241d},        
  {"green", 0x98971a},
  {"yellow", 0xd79921},    
  {"blue", 0x458588},      
  {"magenta", 0xb16286}
}

local palette = { gruvbox_palette, standard_palette}
local palette_number = 2

function change_color_layout()
    if palette_number == 1 then
        palette_number = 2 
    else
        palette_number = 1 
    end
    color(1)
end


function select_tool(tool)
    current_tool = tool
    if tool == 1 then 
        app.uiAction({["action"] = "ACTION_TOOL_ERASER"})
    elseif  current_tool == 2 then
        app.uiAction({["action"] = "ACTION_TOOL_DEFAULT"})
    elseif current_tool ==3 or current_tool ==4 then 
        app.uiAction({["action"] = "ACTION_TOOL_"..tools[current_tool]})
    else
        app.uiAction({["action"] = "ACTION_TOOL_ERASER_DELETE_STROKE"})
    end
    print("Tool:" .. tools[current_tool])
end

function style_lines(mod)
    current_tool = mod
    app.uiAction({["action"] = "ACTION_TOOL_LINE_STYLE_"..style_of_lines[current_tool]})
    print("Style_of_line:" .. style_of_lines[current_tool])
end

function color(selected_color)
  local currentPalette = palette[palette_number]
  currentColor = selected_color
  app.changeToolColor({["color"] = currentPalette[currentColor][2], ["selection"] = true})
  print("Palette: "..currentPalette[1][2].." Color: " .. currentPalette[currentColor][1])
end

function shapes(shape)
    current_shape = shape
    app.uiAction({["action"] = "ACTION_" .. shape_list[current_shape]})
    print("Shape:" .. shape_list[current_shape])
end


-- First row
function erase() select_tool(1) end
function pen() select_tool(2) end
function highlight() select_tool(3) end
function text() select_tool(4) end
    --CTRL
function erase_mod() select_tool(5) end
function pen_dash() style_lines(1) end
function pen_dot() style_lines(2) end
function pen_dash_dot() style_lines(3) end

-- Second row
function white() color(2) end
function red() color(3) end
function green() color(4) end
    -- ctrl
function yellow() color(5) end
function blue() color(6) end
function purple() color(7) end

-- Third row
function select_arrow() shapes(1) end
function select_rect() shapes(2) end
function select_area() shapes(3) end
    -- ctrl
function arrow() shapes(4) end
function rect() shapes(5) end
function circle() shapes(6) end


function linestyle()
  currentLinestyle = currentLinestyle % #linestyleList + 1
  app.uiAction({["action"] = "ACTION_TOOL_LINE_STYLE_" .. linestyleList[currentLinestyle]})
  print("ACTION_TOOL_LINE_STYLE_" .. linestyleList[currentLinestyle])
end

function select()
  currentSelect = currentSelect % #selectList + 1
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_" .. selectList[currentSelect]})
  print("ACTION_TOOL_SELECT_" .. selectList[currentSelect])
end

function tool()
  currentTool = currentTool % #toolList + 1
  if (toolList[currentTool] == "SELECTION") then
    app.uiAction({["action"] = "ACTION_TOOL_SELECT_" .. selectList[currentSelect]})
    print("ACTION_TOOL_SELECT_" .. selectList[currentSelect])
  else   
    app.uiAction({["action"] = "ACTION_TOOL_" .. toolList[currentTool]})
    print("ACTION_TOOL_" .. toolList[currentTool])
  end
end

function eraser()
  currentEraser = currentEraser % #eraserList + 1
  app.uiAction({["action"] = "ACTION_TOOL_ERASER_" .. eraserList[currentEraser]})
  print("ACTION_TOOL_ERASER_" .. eraserList[currentEraser])
end

function drawingtype()
  currentDrawingtype = currentDrawingtype % #drawingtypeList + 1
  app.uiAction({["action"] = "ACTION_" .. drawingtypeList[currentDrawingtype]})
  print("ACTION_" .. drawingtypeList[currentDrawingtype])
end
