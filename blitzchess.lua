--[[ Nur die Objecte müssen blanla--]]

times = { a = 2, b = 2}
starttimes = {a=300,b=300}
currentPlayer = 0

function onLoad()
    print(currentPlayer)
    counterObjA = getObjectFromGUID('c980a1')
    counterObjB = getObjectFromGUID('f9ab2f')

    activateObjA = getObjectFromGUID('6fbaed')
    activateObjA.createButton({
        click_function="changeToA",
        position={0, 0.5, 0},
        color = {1, 1, 1},
        function_owner=self, width=1550, height=3800,
        tooltip="A Clock",
        rotation = {180, 0, 180},
        font_size = 340,
        label="WHITE"
    })
    activateObjB = getObjectFromGUID('51cfcf')
    activateObjB.createButton({
        click_function="changeToB",
        position={0, 0.5, 0},
        color = {0,0,0},
        function_owner=self, width=1550, height=3800,
        tooltip="A Clock",
        font_size = 340,
        font_color = {1, 1, 1},
        label="BLACK"
    })
    activateObjPause = getObjectFromGUID('ca2fa4')
    activateObjPause.createButton({
        click_function="changeToPause",
        position={0, 0.5, 0},
        color = {1,0.3,0.2},
        width=1200, height=600,
        tooltip="Linksklick = Pause, Rechtsklick = Reset",
        function_owner=self
    })

    activateObjAddMinute = getObjectFromGUID('d8514b')
    activateObjAddMinute.createButton({
        click_function="addMinute",
        position={0, 0.5, 0},
        color = {0.3,0.3,1},
        width=1200, height=600,
        tooltip="Linksklick = Minute hinzufügen, Rechtsklick = Minute entfernen",
        function_owner=self
    })

    counterObjA.setValue(tostring(math.ceil(times.a)))
    counterObjB.setValue(tostring(math.ceil(times.b)))
end

function addMinute(obj, color, alt_click)
    if alt_click == false then
        starttimes.a = starttimes.a+60
        starttimes.b = starttimes.b+60
    else
        starttimes.a = starttimes.a-60
        starttimes.b = starttimes.b-60
    end
    resetToStartTimes()
end
function resetToStartTimes()
    times.a=starttimes.a
    times.b=starttimes.b
end
function changeToA(obj, color, alt_click)
    currentPlayer = 1
    print('Changing to A ?')
end
function changeToB(obj, color, alt_click)
    currentPlayer = 2
end
function changeToPause(obj, color, alt_click)
    if alt_click == true then
        resetToStartTimes()
        currentPlayer=0
    else
        if currentPlayer <= 2 then
            currentPlayer = currentPlayer+2
        else
            currentPlayer = currentPlayer-2
        end
    end
end

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
    if currentPlayer == 1 then
        times.a = times.a - Time.delta_time
    elseif currentPlayer == 2 then
        times.b = times.b - Time.delta_time
    end
    counterObjA.setValue(SecondsToClock(times.a))
    counterObjB.setValue(SecondsToClock(times.b))

    if times.a <= 0 then
        currentPlayer = 0
        
        counterObjA.setValue('TIME OUT')
    end
    if times.b <= 0 then
        currentPlayer = 0
        
        counterObjB.setValue('TIME OUT')
    end
end

function SecondsToClock(seconds)
    local minutes = math.floor(seconds / 60)
    local seconds = math.floor(seconds % 60)
    local filler = ''

    if seconds < 10 then
        filler='0'
    end
  
    
    return minutes..':'..filler..seconds
end

