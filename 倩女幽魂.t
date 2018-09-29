isdebug=true
function mTracePrint(str)
    if(isdebug) then
        traceprint(str)
    end
end
function mMessageBoxEx(str,time)
    messageboxex(str, time, 0, 720, 200, 10)
end
function countDown(str,count)
    for i=0,count,1 do
        messageboxex(str..(count-i),(count*1000),0,720,200,10)
        Sleep(1000)
    end
end
function mFindMultiColorNoTap(array)
    local x,y,ret=-1,-1,-1
    x,y,ret=findmulticolor(array[2],array[3],array[4],array[5],array[6],array[7],0.8,0)
    if ret~=-1 then
        mTracePrint(array[1]..x..","..y)
        return true
    end
    return false
end
function mFindMultiColor(array)
    --自定义多点找色
    --	for i=0,#array,1 do
    --        (array[i])
    --    end
    local x,y,ret=-1,-1,-1
    x,y,ret=findmulticolor(array[2],array[3],array[4],array[5],array[6],array[7],0.8,0)
    if ret~=-1 then
        tap(x,y)
        mTracePrint("color"..array[1]..x..","..y)
        return true
    end
    return false
end
function mFindMultiColor_offset(array,offsetX,offsetY)
    --自定义多点找色,偏移点击
    local x,y,ret=-1,-1,-1
    x,y,ret=findmulticolor(array[2],array[3],array[4],array[5],array[6],array[7],0.8,0)
    if ret~=-1 then
        x=x+offsetX
        y=y+offsetY
        tap(x,y)
        mTracePrint("识色:"..array[1]..x..","..y)
        return true
    end
    return false
end
--直到出现某颜色
function mFindMultiColorAppear(array,istap,sleeptime)
    local x,y,ret=-1,-1,-1
    while(true) do
        x,y,ret=findmulticolor(array[2],array[3],array[4],array[5],array[6],array[7],0.8,0)
        if(ret~=-1)then
            mTracePrint("appear: "..array[1])
            if(istap) then
                tap(x,y)
            end
            return x,y,true
        else
            Sleep(sleeptime)
            mTracePrint("wait appear: "..array[1])
        end
    end
end
function mFindText(index,array)
    --自定义找字
    local x,y,ret = -1,-1,-1
    if(usedict(index)) then
        x,y,ret = findtext(array[1],array[2],array[3],array[4],array[5],array[6],array[7])
        if(ret~=-1) then
            tap(x,y)
            mTracePrint("找字:"..array[5]..",".."X:"..x.."Y:"..y)
            return true
        end
    end
    return false
end
function mFindTextNoTap(index,array)
    --自定义找字
    local x,y,ret = -1,-1,-1
    if(usedict(index)) then
        x,y,ret = findtext(array[1],array[2],array[3],array[4],array[5],array[6],0.9)
        if(ret~=-1) then
            --tap(x,y)
            mTracePrint("找字:"..array[5]..",".."X:"..x.."Y:"..y)
            return true
        end
    end
    return false
end
function mFindText_offset(index,array,offset_x,offset_y)
    --自定义找字,偏移点击
    local x,y,ret = -1,-1,-1
    if(usedict(index)) then
        x,y,ret = findtext(array[1],array[2],array[3],array[4],array[5],array[6],array[7])
        if(ret~=-1) then
            x=x+offset_x
            y=y+offset_y
            tap(x,y)
            mTracePrint("找字:"..array[5]..",".."X:"..x.."Y:"..y)
        end
    end
end
function mCmpColor(array)
    --自定义比色
    if(cmpcolor(array[2],array[3],array[4],array[5])) then
        messagebox("cmp:"..array[1])
        return true
    else
        return false
    end
end
function mCmpColorEx(array)
    --自定义多点比色
    local ret=cmpcolorex(array[2],array[3]) 
    if ret then
        m("cmpex:"..array[1])
        return true
    else
        return false
    end 
end
function mFindPic(array)
    --自定义区域找图
    local x,y,ret=-1,-1,-1
    x,y,ret=findpic(array[2],array[3],array[4],array[5],array[6],array[7],array[8],0.8,0)
    if ret~= -1 then
        tap(x,y)
        mTracePrint("pic:"..array[1]..ret)
        return true
    end
    return false
end
function keepTheScreen(id,Arr)
    Sleep(500)
    if(id==0) then
        if(mFindMultiColorNoTap(Arr))then
        end
    end
    if(id==1) then
        mFindText(Arr)
    end
    releasecapture(id)
end
--滑动
function mTouch(x1,y1,x2,y2,time,id)
    touchdown(x1,y1,id)
    touchmove(x2,y2,id)
    Sleep(time)
    touchup(id)
end
-------------------------------广告----------------------------------------
--启动广告
function Advertising()
    messageboxex("-------------|飞天恶魔-辅助|-----------\nQQ群:624918716\n持续更新,完全免费,请多多支持~~\nPS:推荐红手指,7*24小时挂机无烦恼~~", 4000, 387, 314, 200, 20)
    --messageboxex("红手指云手机年中大放送，618低至0.5元每天！仅此一天！", 5000, 387, 314, 200, 20)
    Sleep(2000)
end
--下载红手指
function download()
    local urlApk="sdcard/rd/hsz.apk"
    local url="http://file.gc.com.cn/app/20180109/RedFingerClient_hsz_v201041_app.apk"
    if(sysfindapp("com.redfinger.app")) then
        messagebox("已经安装红手指 无需再安装")
        return
    end
    local body = httpdownload(url,urlApk)
    if(body==true) then
        messagebox("下载红手指成功")
        mTracePrint("下载红手指成功")
    end
    if(installapk(urlApk))then
        messagebox("红手指安装成功")
    end
end
--时间任务管理
function nowTime()
    local at=timenow()
    nowHour=timehour(at)
    nowMinute=timeminute(at)
    mTracePrint("Time: "..nowHour..":"..nowMinute)
    return nowHour,nowMinute
end
function checkTimeTask()
    --采薇:0:30 12:30 14:30 16:30  18:30 21:30 23:30
    --守财奴: 13点后的每个15分 30分 00分
    MiserDestID=-1
    CaiWeiDestID=-1
    DoMiser=false
    DoCaiWei=false
    nowTime()
    if(IsCaiWei) then
        if(nowMinute>=28) then
            if(nowHour==0 or nowHour==9 or nowHour==12 or nowHour==14 or nowHour==16 or nowHour==18 or nowHour==21 or nowHour==23) then
                DoCaiWei=true
            else
                DoCaiWei=false
            end
        end
    end
    if(DoCaiWei)then
        CaiWeiDestID=rnd(0,2)
        mTracePrint("采薇时间:"..nowHour.."-"..nowMinute)
        mTracePrint("采薇地图:"..CaiWeiDestID)
    else
        if(nowHour>=13) then
            --任务时间内
            if(nowMinute>=58)then
                --兰若寺
                MiserDestID=0
            elseif(nowMinute >= 13 and nowMinute < 17) then
                --黑风洞
                MiserDestID=1
            elseif(nowMinute >= 28 and nowMinute < 32)then
                --兰若地宫
                MiserDestID=2
            end
            if(MiserDestID~=-1) then
                DoMiser=true
                mTracePrint("守财时间:"..nowHour..":"..nowMinute)
                mTracePrint("守财地图:"..MiserDestID)
            end
        end
    end
end
----------------------------------------------------------------------------
--去他妈的API
function wtf()
    traceprint("wtf")
    --sysstartapp根本没有返回值
    local ret = sysstartapp("com.netease.l10")
    messagebox(ret)
    traceprint(ret)
    --sysisrunning根本就用不了
    local ret=sysisrunning("com.netease.l10")
    messagebox(ret)
    --setfloatwindowpos又是个假函数,根本没效果
    setfloatwindowpos(0.1,true)
end
--入口
function floatwinrun()
    --Advertising()
    init()
    --cs()
    if(checkgetselected("CheckBoxMaster")) then
        startMaster()
    end
    if(checkgetselected("CheckBoxZLT")) then
        startZLT()
    end
    if(checkgetselected("CheckBoxBT")) then
        startBT()
    end
    if(checkgetselected("CheckBoxDragon")) then
        startDragonTask()
    end
    JQFB()
    InviteCount=0
    CleanCount=0
    ImpSkillCount=0
    ShoutCount=0
    OnHookFlag=true
    closeAllWindow()
    --挂机
    while(true) do
        checkTimeTask()
        --守财奴
        if(checkTeamNum(3))then
            --采薇
            if(DoCaiWei) then
                OnHookFlag=true
                startCaiWei()
                --守财奴    
            elseif(DoMiser) then
                OnHookFlag=true
                startMiser()
            end
        else
            mTracePrint("队伍人数不足..")
        end
        --挂机
        if(IsOnHook and OnHookFlag) then
            if(onHook())then
                OnHookFlag=false
            end
        end
        --挂机邀请附近玩家
        if(IsHookInvite)then
            InviteCount=InviteCount+1
            if(InviteCount>=10) then
                InviteCount=0
                if(checkTeamNum(InvitePeopleLimit)) then
                    mTracePrint("队伍人数足够")
                    mMessageBoxEx("队伍人数足够...",2000)
                else
                    Sleep(1000)
                    nearOfPeople()
                end
            end
        end
        --使用技能
        if(IsUseImpSkill) then
            ImpSkillCount=ImpSkillCount+1
            if(ImpSkillCount>=(ImpSkillCD*2))then
                ImpSkillCount=0
                if(mFindMultiColorNoTap(shrinkBar)) then
                    wnjn()
                else
                    mFindMultiColor(color_window_close)
                end
            end
        end
        --无脑技能
        if(EndlessModel) then
            while(true) do
                wnjn()
                mMessageBoxEx("EndlessModel",1000)
                Sleep(EndlessModelCD)
            end
        end
        --掉线重连
        if(GameRecon) then
            if(getTopAppPackageNameEx()~=UserPackage) then
                countDown("应用异常,重启倒计时:",10)
                sysstartapp(UserPackage)
                countDown("进入游戏倒计时...",20)
                while(getTopAppPackageNameEx()==UserPackage) do
                    if(loginGame())then
                        mMessageBoxEx("登陆游戏成功..",2000)
                        break
                    else
                        closeAllWindow()
                    end
                    Sleep(1000)
                end
            end
        end
        --清理包裹
        if(IsCleanBag) then
            CleanCount=CleanCount+1
            if(CleanCount>=(CleanBagCD*2)) then
                closeAllWindow()
                if(cleanBag())then
                    CleanCount=0
                end
            end
        end
        --喊话
        if(IsShout)then
            ShoutCount=ShoutCount+1
            if(ShoutCount>=ShoutCD*2)then
                ShoutCount=0
                shout()
            end
        end
        mMessageBoxEx("Count..."..InviteCount.." "..ImpSkillCount.." "..CleanCount,2000)
        traceprint(InviteCount.." "..ImpSkillCount.." "..CleanCount)
        Sleep(2000)
        countDown("挂机中..",28)
    end
end
function init()
    --全局变量
    DRAGON_COUNT=0
    DragonMaxCount=4
    DragonPeoLimit=3
    DRAGON_NOFIND_COUNT=0
    ZLT_COUNT=0
    IsAutoMatic=1
    BAOTU_NOTFIND_COUNT=0
    --窗口
    color_hd_close={"关闭活动窗口",1206,11,1250,45,"5A718C-111111","-4|5|314963-111111,7|5|84A6B5-111111,1|6|FFFFFF-111111,-6|-2|F7FFFF-111111,12|-15|4A7184-111111"}
    color_fl_close={"关闭福利窗口",1165,19,1209,55,"FFFFFF-111111","-5|0|42617B-111111,-2|-6|42617B-111111,10|-20|8CB6BD-111111,-5|-5|FFFFFF-111111,-2|-12|73AAF7-111111"}
    color_task_close={"关闭易市-任务-组队-窗口",1122,18,1155,48,"FFFFFF-111111","-5|0|314D63-111111,-2|-5|ADCFD6-111111,2|-3|FFFFFF-111111,6|0|84A6B5-111111,0|4|FFFFFF-111111"}
    color_store_close={"关闭NPC购买窗口",1177,23,1226,61,"FFFFFF-101010","13|13|FFFFFF-101010,-16|14|E7FFFF-101010,-9|3|294563-101010,0|6|081C39-101010,-12|18|5279A5-101010,-13|3|5A799C-101010,-6|-1|082039-101010"}
    color_match_close={"关闭调整组队目标窗口",937,92,971,125,"FFFFFF-111111","-5|0|426173-111111,-3|-3|FFFFFF-111111,-1|-5|ADC7CE-111111,6|0|638694-111111,3|-3|FFFFFF-111111"}
    color_adwinodw_close={"广告窗口",1216,21,1242,46,"FFFFFF-101010","-5|0|42617B-101010,6|1|5A718C-101010,4|-2|FFFFFF-101010,-4|-3|FFFFFF-101010,-1|-5|183452-101010,0|7|213C5A-101010"}
    color_windowlist={color_hd_close,color_fl_close,color_task_close,color_store_close,color_match_close,color_adwinodw_close}
    --活动窗口
    color_activity={"打开活动界面:",973,28,1037,82,"CE3018-101010","-13|8|FFFFD6-101010,4|14|FFFBB5-101010,11|-9|B57D18-101010,-15|1|D69E21-101010,15|9|FFFFD6-101010"}
    dailyBar={"日常面板",157,91,216,230,"FFFFFF-101010","20|1|FFFBFF-101010,26|9|FFFFFF-101010,31|18|FFFFFF-101010,28|6|BDCFDE-101010,23|2|A5BECE-101010,3|9|ADC3D6-101010,9|19|84A6BD-101010"}
    dailyBarSelected={"日常面板-选中",157,91,216,230,"C6DBEF-101010","-6|-6|EFF3FF-101010,6|-5|FFFBFF-101010,10|-2|FFFFFF-101010,-24|-6|FFFFFF-101010,-30|3|FFFFFF-101010,-17|12|DEEBF7-101010,-7|12|FFFFFF-101010,1|12|EFF7FF-101010"}
    --
    shrinkBar={"收缩面板",253,144,293,184,"DEF7FF-101010","11|-11|DEF7FF-101010,11|10|DEF7FF-101010,-6|0|CEEBF7-101010,-8|0|3175BD-101010,12|0|2971BD-101010,16|-4|5AA6E7-101010"}
    color_taskbar_on={"选中任务栏",35,145,64,177,"7391AC-111111","-4|7|FFFFFF-111111,-3|10|D6DBDE-111111,-1|11|D6DFE6-111111,-2|5|19394A-111111,2|11|F7F3F7-111111"}
    color_taskbar_off={"未选中任务栏",35,145,64,177,"215D94-111111","-4|6|4A92EF-111111,-2|8|083042-111111,-3|11|397DCE-111111,-3|22|082831-111111,-3|19|397DCE-111111"}
    color_teambar_selected={"未选中队伍栏",61,145,213,180,"4A8EE7-222222","20|20|4282D6-222222,43|8|3975BD-222222,-76|9|EFEFF7-222222,-77|13|FFFFFF-222222,-74|9|849AA5-222222"}
    color_teambar_unselected={"选中队伍栏",129,138,233,183,"D6F3FF-222222","5|7|EFEFF7-222222,21|20|9C9AAD-222222,27|19|94AECE-222222,24|9|EFEFF7-222222"}
    color_applylistbar_selected={"入队申请栏选中",1150,286,1198,319,"6B86AD-111111","-3|3|FFFBFF-111111,-2|4|424963-111111,-1|6|101C42-111111,13|6|3982CE-111111,18|6|73E3F7-111111"}
    color_applylistbar_unselected={"入队申请栏未选中:",1146,130,1202,317,"C6D3E7-101010","0|6|C6D3E7-101010,0|12|C6D3E7-101010,-8|7|424D6B-101010,6|8|101831-101010,28|-90|6BDBF7-101010"}
    color_teaminfobar_unselected={"队伍信息栏",1144,114,1182,229,"B5C3D6-111111","4|15|C6D3E7-111111,-2|36|B5BED6-111111,21|47|B5C3DE-111111,12|52|A5B2CE-111111"}
    --callFollow={"召唤跟随..",10,255,100,539,"EFEBEF-101010","0|10|1061AD-101010,-18|0|EFEFEF-101010,-42|0|1059A5-101010,7|-24|7BE3FF-101010,4|-5|F7F7FF-101010"}
    callFollow={"召唤跟随测试",14,257,81,540,"F7F3F7-101010","6|8|F7F7FF-101010,12|-1|F7F7FF-101010,13|-4|FFFFFF-101010,16|5|105DA5-101010,-6|6|1061AD-101010,23|4|EFF3F7-101010,26|-4|FFFFFF-101010,31|4|EFEBEF-101010,31|10|105DA5-101010"}
    cancelFollow={"取消跟随",130,190,207,550,"F7F7FF-101010","5|-9|F7FBFF-101010,7|1|105DA5-101010,10|3|FFFFFF-101010,15|4|105DA5-101010,16|-19|42B6DE-101010,25|7|F7F7F7-101010"}
    --师门
    color_joinMaster={"参加师门",333,80,1171,646,"2171B5-101010","0|-6|F7FBFF-101010,-263|-44|FFFFFF-101010,-260|-46|94A2AD-101010,-253|-41|214573-101010,-245|-42|FFFFFF-101010,-247|-31|FFFBFF-101010,-249|-27|395D84-101010,-256|-31|8492A5-101010"}
    color_alreadyMaster={"已接师门",333,80,1171,646,"63E36B-101010","9|7|6BE76B-101010,-272|-29|FFFFFF-101010,-269|-31|94A2AD-101010,-262|-26|214573-101010,-254|-27|FFFFFF-101010,-256|-16|FFFBFF-101010,-258|-12|395D84-101010,-265|-16|8492A5-101010"}
    color_doMaster={"执行师门",18,193,66,447,"FFC700-101010","0|13|EFBA00-101010,-3|17|E7BA00-101010,4|14|F7C300-101010,13|14|EFBE00-101010,10|4|F7BE00-101010,20|-1|DEB600-101010,36|0|FFC700-101010,19|17|DEB200-101010"}
    color_leaveFB={"离开副本",765,406,799,438,"FFFBF6-111111","3|-2|E6E3DE-111111,1|1|CDAA8C-111111,-1|-4|E69621-111111,3|0|734521-111111,6|-2|FFFFFF-111111"}
    color_window_close={"关闭窗口",350,0,1280,720,"D6FBF7-000000","24|-5|FFFFFF-000000,27|26|FFFFFF-000000,-4|26|E6FBFF-000000"}
    color_revive={"默认地点复活",529,221,680,471,"F7F7FF-101010","-12|2|FFFFFF-101010,8|3|FFFFFF-101010,-16|10|F7F7FF-101010,-11|10|3182C6-101010,-3|-1|EFF7FF-101010,-15|-9|6BB2E7-101010,14|10|FFFFFF-101010"}
    pic_buy={"购买物品:",867,550,1174,672,"/sdcard/ais_debug/","buy.bmp",222222}
    pic_use={"使用物品:",945,289,1159,502,"/sdcard/ais_debug/","use.bmp",222222}
    color_use={"使用物品",1020,452,1056,484,"FFFFFF-222222","-16|10|A5CFEF-222222,-12|9|ADBECE-222222,-10|22|4A6D94-222222,-6|24|215184-222222,-9|4|21517B-222222"}
    color_auto_match={"自动匹配",129,84,859,141,"F7FBFF-101010","27|20|CEE3F7-101010,23|12|FFFBFF-101010,18|9|D6DFE7-101010,36|5|ADD7F7-101010,-584|7|D69A4A-101010"}
    color_cancel_automatch={"取消自动匹配",719,87,817,134,"94AABD-101010","0|-16|8CD7EF-101010,-17|-12|E7EFEF-101010,-3|10|FFFFFF-101010,-1|15|2975BD-101010,8|-4|F7F7FF-101010"}
    color_talk={"NPC对话",1198,650,1244,689,"52B6DE-111111","12|4|7BEFFF-111111,17|5|7BF3FF-111111,28|0|52BEE7-111111,27|7|7BE7F7-111111,6|7|73D7E7-111111"}
    automatic={"自动战斗..",1208,325,1258,392,"29DFEF-101010","5|7|AD7939-101010,-8|39|F7EFCE-101010,-12|42|A58E6B-101010,-16|45|FFFBBD-101010,-21|55|FFF78C-101010,-7|53|FFF794-101010"}
    cancelAutoMaitc={"取消自动战斗..",1222,319,1255,390,"31E7F7-101010","6|7|A57129-101010,-6|10|4A6963-101010,-1|41|EFE3BD-101010,-7|43|FFFBCE-101010,-7|48|FFF7AD-101010,0|55|FFF78C-101010"}
    FbFlag={"副本中标志",1055,101,1112,160,"9CEF3A-101010","-8|-15|FFFF52-101010,-21|11|21CAFF-101010,-10|3|6BDB08-101010,-23|16|31C2EE-101010,-28|16|EEC610-101010,-7|23|FFFFFF-101010"}
    --一条龙
    color_doDragon={"执行一条龙",8,189,138,451,"E6BA00-101010","-4|-5|FFC608-101010,-13|-13|EEBE00-101010,-10|-17|F7C200-101010,-20|-17|F7C208-101010,46|-13|FFC600-101010,46|-6|E6BA00-101010,41|-1|EEBA00-101010,45|-10|EEBE00-101010"}
    --战龙堂
    color_do_zl={"执行战龙",12,193,69,450,"FFC700-101010","-7|0|F7C300-101010,9|-2|F7C300-101010,11|13|F7C300-101010,0|12|F7C700-101010,-21|12|FFC700-101010,-29|13|FFC700-101010,-25|-5|F7C300-101010,-19|2|F7C300-101010"}
    color_joinZLT={"参加战龙堂",333,80,1171,646,"3179BD-101010","-7|-3|FFFFFF-101010,-235|-34|FFFBFF-101010,-227|-39|FFFFFF-101010,-211|-36|FFFFFF-101010,-207|-36|FFFFFF-101010,-232|-26|E7EBEF-101010,-207|-23|EFF3F7-101010,-238|-42|FFFFFF-101010"}
    --守财奴标志
    miserLogo2={"守标志..",910,117,1115,157,"F7D329-101010","1|-6|FFEF9C-101010,0|-11|E7DBAD-101010,0|-17|FFFFEF-101010,-9|-10|F7EBB5-101010,-4|1|EFCF18-101010,15|-18|392818-101010,2|-21|DEDBDE-101010"}
    --[[--------------------------初始化字库------------------------------------]]--
    setrotatescreen(1)
    --[[--------------------------获取UI配置------------------------------------]]--
    --师门购买放弃
    MasterBack=checkgetselected("CheckBoxMaster_back")
    --一条次数 人数
    DragonMaxCount = editgettext("DragonCountEdit")
    DragonPeoLimit = editgettext("DragonPeopleEdit")
    DragonMaxCount=tonumber(DragonMaxCount)
    DragonPeoLimit=tonumber(DragonPeoLimit)
    --清包间隔
    IsCleanBag=checkgetselected("CheckBoxCleanBag")
    CleanBagCD=editgettext("CleanBagCD")
    CleanBagCD=tonumber(CleanBagCD)
    --挂机地图坐标
    IsOnHook=checkgetselected("CheckBoxOnHook")
    HookMapId=getSelectsCheckItemIndex("SelectOnHookMap")
    HookPointX=editgettext("OnHookX")
    HookPointY=editgettext("OnHookY")
    HookPointX=tonumber(HookPointX)
    HookPointY=tonumber(HookPointY)
    --邀请附近玩家
    IsHookInvite=checkgetselected("CheckBoxHookInvite")
    InvitePeopleLimit=editgettext("InvitePeopleLimit")
    InvitePeopleLimit=tonumber(InvitePeopleLimit)
    --绝技
    IsUseImpSkill=checkgetselected("CheckBoxImpSkill")
    ImpSkillCD=editgettext("ImpSkillCD")
    ImpSkillCD=tonumber(ImpSkillCD)
    EndlessModel=checkgetselected("EndlessModel")    
    EndlessModelCD=editgettext("EndlessModelCD")
    EndlessModelCD=tonumber(EndlessModelCD)
    FirSkill=checkgetselected("FirSkill")
    SecSkill=checkgetselected("SecSkill")
    ThirdSkill=checkgetselected("ThirdSkill")
    FourSkill=checkgetselected("FourSkill")
    FiveSkill=checkgetselected("FiveSkill")
    SixSkill=checkgetselected("SixSkill")
    SevSkill=checkgetselected("SevSkill")
    --技能坐标
    SKILL_SWITCH={FirSkill,SecSkill,ThirdSkill,FourSkill,FiveSkill,SixSkill,SevSkill}
    SKILL_LIST={{1150,584},{1027,660},{1033,538},{1118,463},{1236,464},{1242,599},{1170,669}}
    SKILL_USE={}
    for i=1,#SKILL_SWITCH do
        if(SKILL_SWITCH[i]) then
            table.insert(SKILL_USE,SKILL_LIST[i])
        end
    end
    --喊话设置
    IsShout=checkgetselected("CheckBoxShout")
    ShoutCD=editgettext("EditShoutCD")
    ShoutCD=tonumber(ShoutCD)
    ShoutContext=editgettext("ShoutContext")
    --守财奴
    IsMiser=checkgetselected("CheckBoxMiser")
    --采薇
    IsCaiWei=checkgetselected("CheckBoxCaiWei")
    --掉线重连
    GameRecon=checkgetselected("CheckBoxRecon")
    UserPackageId= getSelectsCheckItemIndex("GamePackage")
    UserPackage=nil
    if(UserPackageId==0) then
        UserPackage="com.netease.l10"
    elseif(UserPackageId==1)then
        UserPackage="com.netease.l10.uc"
    elseif(UserPackageId==2)then
        UserPackage="com.netease.l10.nearme.gamecenter"
    elseif(UserPackageId==3) then
        UserPackage="com.netease.l10.mi"
    elseif(UserPackageId==4) then
        UserPackage="com.netease.l10.vivo"
    elseif(UserPackageId==5) then
        UserPackage="com.netease.l10.huawei"
    elseif(UserPackageId==6) then
        UserPackage="com.netease.l10.mz"
    elseif(UserPackageId==7) then
        UserPackage="com.quicksdk.qnyh.youlong"
    elseif(UserPackageId==8) then
        UserPackage="com.netease.l10.downjoy"
    end
    --[[--------------------------初始化游戏界面------------------------------------]]--
    --切到任务栏
    mTracePrint("-----------初始化游戏界面--------------------")
    while(true) do
        if(mFindMultiColorNoTap(color_taskbar_on)) then
            break
        else
            if(mFindMultiColor(color_taskbar_off))then
                Sleep(1000)
            else
                closeAllWindow()
            end
        end
    end
    mTracePrint("-------------------------------")
end
--关闭所有窗口
function closeAllWindow()
    for i=1,#color_windowlist do
        if(mFindMultiColor(color_windowlist[i]))then
            mMessageBoxEx("关闭窗口.."..i,1000)
        end
        Sleep(500)	
    end
end
--掉线重连
function loginGame()
    local login={"登入游戏",637,590,706,631,"ADFBFF-101010","11|-1|84D3EF-101010,11|-12|ADFBFF-101010,-4|-13|9CE7F7-101010,-10|3|2975B5-101010,-3|8|A5F3FF-101010"}
    local login_confrim={"离线经验",608,400,677,436,"2975BD-101010","-3|-11|FFFFFF-101010,3|-21|E7EBF7-101010,-10|-24|849EB5-101010,-13|-15|F7F7F7-101010,-3|-8|FFFFFF-101010,10|-6|FFFFFF-101010"}
    local enforlogin={"强行登陆",762,407,805,441,"E78E18-101010","10|-8|FFFFFF-101010,16|-5|FFFBF7-101010,13|1|F7E3D6-101010,9|7|DEAE73-101010,8|3|CEAA84-101010"}
    local oppoAd={"关闭OPPO广告",922,54,961,96,"00D683-101010","-4|4|00D683-101010,4|4|00D683-101010,7|-6|00D683-101010,-1|-9|F3F5F2-101010,-5|-5|00D683-101010,0|10|F2F6F2-101010"}
    local oppoAuth={"跳过OPPO实名",492,532,787,575,"363636-101010","-17|14|373737-101010,5|16|363636-101010,12|20|363636-101010,3|5|FFFFFF-101010,154|8|3FCAB8-101010,169|10|FFFFFF-101010,165|-3|3FCAB8-101010"}
    local actorInto={"角色-进入游戏",1140,627,1226,677,"ADF7FF-101010","3|-6|ADFBFF-101010,10|-7|A4F3FF-101010,20|-2|ADF7FF-101010,30|-3|ADFBFF-101010,30|-27|21C6EE-101010,66|-13|10C2EE-101010"}
    local vivoAd={"关闭VIVO广告",897,166,941,205,"4E4E4E-101010","-4|-4|575757-101010,4|-4|4E4E4E-101010,0|7|F1F2F2-101010,-1|-6|F1F2F2-101010,-10|10|4E4E4E-101010"}
    local hwAd={"关闭华为广告:",589,586,685,624,"007DFF-101010","-6|-4|007DFF-101010,-22|-3|007DFF-101010,-22|10|007DFF-101010,-19|8|F7F7F7-101010,-11|12|F7F7F7-101010,9|12|007DFF-101010"}
    if(UserPackageId==2) then
        mMessageBoxEx("oppo",2000)
        mFindMultiColor(oppoAuth)
        Sleep(2000)
        mFindMultiColor(oppoAd)
    elseif(UserPackageId==3) then
        mMessageBoxEx("小米",2000)
    elseif(UserPackageId==4) then
        mMessageBoxEx("VIVO",2000)
        mFindMultiColor(vivoAd)
    elseif(UserPackage==5) then
        mMessageBoxEx("华为",2000)
        mFindMultiColor(hwAd)
    elseif(UserPackage==6) then
        mMessageBoxEx("魅族",2000)
    elseif(UserPackage==7) then
        mMessageBoxEx("19196",2000)
    elseif(UserPackage==8) then
        mMessageBoxEx("当乐",2000) 
    end
    mFindMultiColor(actorInto)
    Sleep(1000)
    mFindMultiColor(login_confrim)
    if(mFindMultiColor(login)) then
        Sleep(2000)
    end
    if(mFindMultiColor(enforlogin)) then
        Sleep(2000)
    end
    if(mFindMultiColor(automatic))then
        return true
    else
        closeAllWindow()
    end
    return false
end
MasterFailedCount=0
function doMaster()
    local ret=-1
    local color_master_find={"师门寻物品",982,463,1096,501,"F7FBFF-222222","1|22|7B96B5-222222,11|20|214973-222222,8|12|FFFFFF-222222,-53|13|102431-222222,-56|13|5AE3F7-222222"}
    local color_master_end_confirm={"确认完成全部师门",613,389,642,436,"8CA6C5-111111","-2|9|DEEFF7-111111,6|8|29517B-111111,19|6|FFFFFF-111111,15|-12|8CE7F7-111111,2|18|29558C-111111"}
    local color_tjp={"铁匠杂货铺",1150,285,1194,502,"FFFBFF-111111","-8|0|7392AD-111111,-2|-13|214573-111111,1|-21|EFF7FF-111111,4|-27|63E7FF-111111,7|1|1869CE-111111"}
    local color_drugstore={"药铺:",956,339,1277,554,"FFFFFF-222222","19|7|9CB6CD-222222,45|20|E6EEFF-222222,23|33|196DD6-222222,23|36|52E6FF-222222,25|-8|73EFFF-222222"}
    local color_submit={"上交物品",356,538,423,592,"F7F7FF-222222","0|-3|3986C6-222222,15|-1|214973-222222,16|-4|FFFFFF-222222,16|-8|4A96D6-222222,10|-30|94E3FF-222222"}
    local color_submit_confirm={"确定上交",413,395,880,460,"A47131-222222","-11|3|F7F3E6-222222,23|11|FFFFFE-222222,26|-1|CEB294-222222,14|-18|F7D673-222222,-49|8|DE8519-222222"}
    local color_master_visit={"师门拜访:",974,346,1257,582,"39E7EF-222222","-5|7|42E7EF-222222,94|-13|F7FBFF-222222,122|10|C6D7E7-222222,113|-25|ADEFFF-222222"}
    local color_buy={"NCP购买",987,616,1030,660,"E6CEB5-101010","3|-2|FFFFFF-101010,9|-3|FFFBF7-101010,1|-8|734921-101010,-5|2|DE8510-101010,10|5|FFFFFF-101010,13|-1|EECAAD-101010"}
    local color_buy2={"易市购买",872,621,1062,663,"FFFFFF-222222","10|15|FFFBF7-222222,11|5|A57539-222222,-5|18|DE7D10-222222,-113|16|DE8210-222222,-113|11|FFFBF7-222222"}
    local color_confirmbuy={"易市确认购买:",709,384,871,446,"AD6D21-222222","14|3|FFFFFF-222222,15|13|946D4A-222222,42|15|EFCB9C-222222,55|-14|FFF7A5-222222"}
    local color_buy_cancle={"易市取消购买",438,395,538,438,"FFFFFF-222222","12|2|FFFFFF-222222,10|15|DEE3EF-222222,24|14|428ECE-222222,46|0|F7FBFF-222222,25|24|2975BD-222222"}
    local color_ys_search={"易市搜索",1051,617,1088,671,"FFF7EF-111111","-6|1|734521-111111,-10|-2|DEB68C-111111,-16|8|FFF7EF-111111,4|1|E79221-111111,3|-9|7B5531-111111"}
    local color_cd={"虫洞...",1184,463,1217,502,"FFFFFF-111111","-10|6|8CA2BD-111111,-2|1|A4CEE6-111111,-4|11|214973-111111,5|11|F7F7FF-111111,-9|19|214973-111111"}
    --69级会出现的情况:
    local color_masterTaskFlag={"接取师门:",980,222,1017,509,"21C3D6-111111","-4|-10|9CBACE-111111,1|-5|396184-111111,-5|6|213042-111111,-14|14|10D7E7-v,-16|-11|D6F7FF-111111"}
    local color_masterSubmit={"提交任务",980,222,1028,499,"E7FFFF-111111","-5|7|398AC6-111111,-4|5|182431-111111,1|6|29E3EF-111111,-9|9|8CEFF7-111111"}
    --左侧任务点击
    if(mFindMultiColor(color_doMaster)) then
        ret=0
    else
        ret=-1
    end
    mMessageBoxEx("doMaster:"..ret,1500)
    if((ret==0) or mFindMultiColor(color_talk))then
        MASTER_FAILED_COUNT=0
        Sleep(1000)
        mFindMultiColor(color_talk)
    end
    --右侧任务确定
    if(mFindMultiColor(color_masterTaskFlag) or mFindMultiColor(color_masterSubmit)) then
        Sleep(1000)
    end
    if(mFindMultiColor(color_submit)) then
        Sleep(1000)
        if(mFindMultiColor(color_submit_confirm))then
            mMessageBoxEx("上交物品...",1000)
        end
    end
    --铁匠 杂货 药铺 拜访冲突处理
    if(mFindMultiColorNoTap(color_tjp) or mFindMultiColorNoTap(color_drugstore)) then
        if(mFindMultiColor(color_master_visit)) then
            mMessageBoxEx("拜访..",1000)
        else
            if(mFindMultiColor(color_tjp))then
                mMessageBoxEx("铁匠杂货铺...",1000)
                Sleep(1000)
            end
            if(mFindMultiColor(color_drugstore))then
                mMessageBoxEx("药铺...",1000)
                Sleep(1000)
            end
        end
        Sleep(1000)
        if(mFindMultiColor(color_buy))then
            Sleep(1000)
            mFindMultiColor(color_windowlist[4])
        end
    end
    mFindMultiColor(color_cd)
    --购买物品是否放弃任务
    if(mFindMultiColor(color_ys_search) or mFindMultiColorNoTap(color_buy2)) then
        Sleep(2000)
        if(MasterBack) then
            mFindMultiColor(color_windowlist[3])
            backupTask()
            Sleep(3000)
            if(getMaster())then
                countDown("重新接取任务成功..",12)
            end
        else
            if(mFindMultiColor(color_buy2))then
                Sleep(2000)
            else
                mFindMultiColor(color_windowlist[3])
            end
            if(mFindMultiColor(color_confirmbuy))then
                mMessageBoxEx("购买...",1000)
                Sleep(1000)
            end
            mFindMultiColor(color_windowlist[3])
            Sleep(1000)
        end
    end
    --关闭和使用物品冲突
    if(mFindMultiColor(color_use) or mFindPic(pic_use)) then
        mMessageBoxEx("使用物品..",1000)
        Sleep(5000)
    end
    mFindMultiColor(color_revive)
    mFindMultiColor(color_leaveFB)
    if(mFindMultiColor(color_master_end_confirm)) then
        mTracePrint("完成全部师门...")
        mMessageBoxEx("师门全部完成...",1000)
        return true
    end
    if(ret==-1) then
        MasterFailedCount=MasterFailedCount+1
        if(MasterFailedCount>=5) then
            MasterFailedCount=0
            closeAllWindow()
        end
    end
    return false
end
function backupTask()
    mMessageBoxEx("backupTask",1000)
    local color_confirm_backup={"确认放弃:",743,405,853,445,"FFFBF7-222222","18|-9|FFFFFF-222222,44|2|FFE7CE-222222,-9|2|E78E18-222222,30|10|DE8210-222222"}
    local color_backup_task={"放弃任务",390,619,511,675,"EFF7FF-222222","21|0|FFFFFF-222222,-14|20|FFFFFF-222222,2|23|2975BD-222222,-27|-10|8CDBF7-222222,-43|13|398AC6-222222"}
    local color_task={"日常任务-backup",180,100,288,541,"8CD3E7-222222","15|19|ADFBFF-222222,33|17|94DFEF-222222,26|-1|A5EFF7-222222,40|-2|5292BD-222222,47|8|84CBE7-222222"}
    local exist_task={"已接任务",1120,10,1179,346,"9CAABD-222222","-14|-38|B5C7DE-222222,-14|10|8C9AB5-222222,-25|-151|FFFFFF-222222,-12|131|E7E7EF-222222,7|134|ADBAD6-222222"}
    --放弃任务
    while(true) do
        Sleep(2000)
        mFindMultiColor(color_taskbar_on)
        Sleep(2000)
        mFindMultiColor(exist_task)
        Sleep(2000)
        mFindMultiColor(color_task)
        Sleep(2000)
        mFindMultiColor(color_backup_task)
        Sleep(2000)
        if (mFindMultiColor(color_confirm_backup)) then
            mMessageBoxEx("确认放弃",1000)
            return true
        end
    end
end
function getMaster()
    --1:已经接取师门 或成功领取
    --0:已完成全部师门
    local color_completeMaster={"师门完成",333,80,1171,646,"949294-202020","-26|0|949294-202020,-183|-3|F7F7FF-202020,-186|-1|FFF7FF-202020,-191|-14|FFFFFF-202020,-225|-13|FFFFFF-202020,-219|-2|F7F7F7-202020,-246|-18|EFEBEF-202020,-250|-1|FFFBFF-202020"}
    local color_experience={"我要经验:",657,25,714,156,"8CBACE-222222","15|-2|ADDFEF-222222,29|1|5A8EA5-222222,45|5|84B2C6-222222,31|3|083452-222222"}
    local color_master_end_confirm={"确认完成全部师门",375,207,904,478,"CEDBEF-222222","29|-13|F7FBFF-222222,0|-110|7B8EA5-222222,210|-113|E7FBFF-222222,22|14|2971BD-222222"}
    mMessageBoxEx("getMaster",1000)
    if(mFindMultiColor(color_doMaster))then
        return 1
    else
        if(mFindMultiColor(color_activity)) then
            Sleep(1500)
            mFindMultiColor(dailyBar)
            Sleep(1500)
            --mFindMultiColor(color_experience)
            if(mFindMultiColor_offset(dailyBarSelected,460,-70)) then
                Sleep(1000)
                if(mFindMultiColor(color_joinMaster)) then
                    mMessageBoxEx("参加师门",2000)
                    Sleep(2000)
                    return 1
                elseif(mFindMultiColorNoTap(color_alreadyMaster))then
                    mMessageBoxEx("已经接取师门..",2000)
                    mFindMultiColor(color_windowlist[1])
                    Sleep(2000)
                    mFindMultiColor(color_windowlist[1])
                    return 1
                elseif(mFindMultiColorNoTap(color_completeMaster)) then
                    mMessageBoxEx("师门全部完成..",2000)
                    mFindMultiColor(color_windowlist[1])
                    Sleep(2000)
                    return 0
                end
            end
        else
            mFindMultiColor(color_windowlist[1])
        end
    end
    return -1
end
function startMaster()
    --师门任务
    local ret=-1
    while(true) do
        ret=getMaster()
        mMessageBoxEx("get master:"..ret,2000)
        if(ret==1) then
            break
        elseif(ret==0) then
            return
        end
        Sleep(2000)
    end
    while(true) do
        if(doMaster())then
            break
        end
    end
end
function startDragonTask()
    --打开活动界面得一条龙
    local color_team={"便捷组队:",1062,405,1178,439,"ADBED6-222222","22|-5|7B8EAD-222222,29|1|B5BED6-222222,86|-5|C6D7E7-222222,93|3|EFF3F7-222222"}
    local color_create_team={"创建队伍",826,633,955,665,"FFFFFF-222222","2|-11|BDCBD6-222222,5|-5|7B92AD-222222,7|3|BDCBD6-222222,14|0|DEDFE7-222222"}
    local color_dragon_team={"组队目标一条龙",132,89,453,140,"8C96A5-222222","5|15|B5B6BD-222222,12|20|C6C7CE-222222,-1|20|FFFBFF-222222,10|10|DEDFE7-222222,-262|5|CE9642-222222"}
    local color_leave_team={"离开队伍",140,630,197,671,"EFF7FF-222222","0|-7|94D3EF-222222,9|21|FFFBFF-222222,-2|19|94A2BD-222222,0|20|214D7B-222222,1|27|2171B5-222222"}
    local color_call_follow={"召唤跟随",832,630,947,676,"FFFFFF-222222","17|10|CED3DE-222222,29|5|B5CBDE-222222,55|2|BDC7D6-222222,45|16|2975BD-222222,45|0|4A8EC6-222222"}
    mMessageBoxEx("一条龙次数:"..DragonMaxCount.." 人数:"..DragonPeoLimit,3000)
    Sleep(2000)
    mMessageBoxEx("startDragonTask",2000)
    mTracePrint("startDragonTask")
    Sleep(2000)
    --true:完成4轮
    while(true) do
        if(mFindMultiColor(color_doDragon))then
            mMessageBoxEx("已经接取一条龙...",2000)
            DRAGON_COUNT=DRAGON_COUNT+1
            Sleep(1000)
            if(doDragonTask())then
                break  
            end
        else
            while(true) do
                if(getDragonTask()) then
                    Sleep(5000)
                else
                    closeAllWindow()
                end
                if(mFindMultiColor(color_team))then
                    Sleep(2000)
                    mFindMultiColor(color_create_team)
                end
                Sleep(2000)
                --有申请会在申请列表
                if(mFindMultiColor(color_teaminfobar_unselected)) then
                    mMessageBoxEx("切到队伍信息..",2000)
                end
                --判断是否在队伍面板
                if(mFindMultiColorNoTap(color_leave_team) and mFindMultiColorNoTap(color_call_follow)) then
                    if(createTeam())then
                        Sleep(2000)
                        if(dragonCheckTeam()) then
                            Sleep(2000)
                            if(doDragonTask()) then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
end
function getDragonTask()
    --获取一条龙任务
    --true:已经完成或者接取成功
    --false:没有接取到任务 
    local color_joindragon={"参加一条龙",281,80,1186,629,"FFFFFF-222222","7|-3|8CA6BD-222222,0|8|317DC6-222222,-188|-11|A5AEBD-222222,-204|-16|FFFFFF-222222,-201|-30|63758C-222222"}
    local color_dragonComplete={"一条龙完成",281,80,1186,629,"FFFBFF-101010","-1|15|FFFFFF-101010,-23|15|848684-101010,-22|-10|949694-101010,-191|-16|FFFFFF-101010,-199|-28|FFFFFF-101010,-191|-26|FFFBFF-101010,-223|-21|FFFFFF-101010,-238|-19|F7F7FF-101010,-222|-8|FFFFFF-101010"}
    mMessageBoxEx("getDragonTask",2000)
    if(mFindMultiColor(color_doDragon))then
        mMessageBoxEx("已经接取一条龙...",2000)
        return true
    end
    if(mFindMultiColor(color_activity)) then
        mMessageBoxEx("活动面板",1000)
        Sleep(2000)
    end
    mFindMultiColor(dailyBar)
    Sleep(2000)
    if(mFindMultiColor_offset(dailyBarSelected,310,-70)) then
        mTracePrint("我要装备")
        Sleep(2000)
        mFindMultiColor(color_joindragon)
        return true
    end
    return false
end
function createTeam()
    --没有队伍,创建队伍
    local color_match_dragon={"调整目标一条龙",395,163,478,528,"E7EBEF-222222","21|0|ADB6C6-222222,43|4|7B8E9C-222222,61|4|638ABD-222222,58|-11|94AECE-222222,67|-7|FFFBFF-222222"}
    local color_open_match={"打开匹配目标",133,84,257,146,"D69A4A-222222","-2|4|FFFBE7-222222,-18|0|FFFFFF-222222,-10|16|CE8218-222222,11|16|FFF7BD-222222,36|3|5AAEE7-222222,63|1|5AAEE7-222222"}
    local color_dragon_confirm={"确定匹配目标",722,542,853,583,"FFFBFF-222222","12|6|FFFFFF-222222,13|13|C6D3DE-222222,28|13|CEE3F7-222222,44|8|5AAADE-222222"}
    mMessageBoxEx("createTeam",2000)
    Sleep(5000)
    while(true) do
        --取消自动匹配
        if(mFindMultiColor(color_cancel_automatch)) then
            mMessageBoxEx("取消自动匹配..",2000)
        end
        mFindMultiColor(color_open_match)
        Sleep(3000)
        if(mFindMultiColor(color_match_dragon)) then
            if(mFindMultiColor(color_dragon_confirm)) then
                return true
            else
                FindMultiColor(color_window_close)
            end
        else
            swipe(503,515,503,172)
            Sleep(3000)
            if(mFindMultiColor(color_match_dragon))then
                if(mFindMultiColor(color_dragon_confirm)) then
                    return true
                else
                    mFindMultiColor(color_window_close)
                end
            end
        end
        Sleep(2000)
    end
end
function dragonCheckTeam()
    --存在队伍,大于三人返回
    local TEAM_NOP=1
    local color_play5={"play5",972,560,988,573,"FFFFFF-111111","1|0|FFFFFF-111111,2|0|FFFFFF-111111,3|0|EEEFF7-111111"}
    local color_play4={"play4",772,562,784,572,"FFFFFF-111111","1|0|FFFFFF-111111,2|0|FFFFFF-111111,3|0|F7F7F7-111111"}
    local color_play3={"play3",572,561,584,571,"FFFFFF-111111","1|0|FFFFFF-111111,2|0|FFFFFF-111111,3|0|FFFFFF-111111"}
    local color_play2={"play2",372,562,384,571,"FFFFFF-111111","1|0|FFFFFF-111111,2|0|FFFFFF-111111,3|0|F7F3F7-111111"}
    local color_play1={"申请入队玩家",170,563,187,575,"CED2D6-111111","1|0|CECED6-111111,2|0|C5CACE-111111,3|0|E6E7E6-111111"}
    local color_acceptjoin={"接受入队",154,323,284,372,"949AA5-222222","17|12|FFFBFF-222222,36|12|6B6D6B-222222,33|21|DE8218-222222,5|-1|F7B642-222222"}
    local color_call_follow={"召唤跟随",832,630,947,676,"FFFFFF-222222","17|10|CED3DE-222222,29|5|B5CBDE-222222,55|2|BDC7D6-222222,45|16|2975BD-222222,45|0|4A8EC6-222222"}
    mMessageBoxEx("dragonCheckTeam.",2000)
    while(true) do
        if(mFindMultiColorNoTap(color_play5)) then
            TEAM_NOP=5
        elseif(mFindMultiColorNoTap(color_play4)) then
            TEAM_NOP=4
        elseif(mFindMultiColorNoTap(color_play3)) then
            TEAM_NOP=3
        elseif(mFindMultiColorNoTap(color_play2)) then
            TEAM_NOP=2
        else
            TEAM_NOP=1
        end
        mMessageBoxEx("TEAM_NOP.."..TEAM_NOP,2000)
        mTracePrint(TEAM_NOP)
        if(TEAM_NOP>=DragonPeoLimit) then
            --达到任务人数,开始任务
            mFindMultiColor(color_auto_match)
            mFindMultiColor(color_call_follow)
            mFindMultiColor(color_window_close)
            Sleep(1000)
            mFindMultiColor(color_taskbar_off)
            return true
        else
            countDown("组队等待..",10)
            if(mFindMultiColor(color_auto_match)) then
                mMessageBoxEx("自动匹配",1000)
            end
            if(mFindMultiColor(color_applylistbar_unselected) or mFindMultiColor(color_applylistbar_selected)) then
                --是否玩家申请入队
                Sleep(2000)
                tap(197,353)
                Sleep(2000)
                mFindMultiColor(color_acceptjoin)
            end
            Sleep(1000)
            if(mFindMultiColor(color_teaminfobar_unselected)) then
                --切回队伍信息栏
                mMessageBoxEx("队伍信息..",1000)
            end
        end
    end
end
function doDragonTask()
    --true:完成4轮
    local INTO=0
    local NotFindCount=0
    local color_acceptjoin={"接受入队",154,323,284,372,"949AA5-222222","17|12|FFFBFF-222222,36|12|6B6D6B-222222,33|21|DE8218-222222,5|-1|F7B642-222222"}
    local dragon_timeleft={"一条龙剩余时间",64,195,155,437,"00FF00-202020","1|0|00FB00-202020,0|1|00FF00-202020,1|1|00FB00-202020,0|9|00EF00-202020,1|9|00E300-202020"}
    local color_dragon_confirm={"确认完成一轮:",766,398,798,441,"FFF7E7-111111","1|2|AD6D21-111111,4|5|734521-111111,5|14|EF9E31-111111,6|17|FFF3EF-111111,2|-11|FFDB73-111111"}
    local color_call_follow={"召唤跟随",832,630,947,676,"FFFFFF-222222","17|10|CED3DE-222222,29|5|B5CBDE-222222,55|2|BDC7D6-222222,45|16|2975BD-222222,45|0|4A8EC6-222222"}
    local color_dragon_in={"进入一条龙副本",977,457,1150,512,"317DBD-101010","-10|-24|E7F3EF-101010,-13|-24|E7EFEF-101010,47|-24|94CFEF-101010,47|11|2171BD-101010,232|13|2175BD-101010,233|-5|398AC6-101010,232|-28|8CDBF7-101010"}
    local color_getTask={"三界异闻",981,336,1086,514,"29D3DE-101010","-6|4|213042-101010,-10|18|10DFEF-101010,-9|2|4A9ACE-101010,54|0|F7FBFF-101010,56|14|F7FBFF-101010,46|4|FFFFFF-101010,60|-2|BDCBDE-101010"}
    local color_deny={"拒绝队长申请..",479,399,517,445,"FFFFFF-222222","-9|17|6B9AC6-222222,-6|9|E7EFFF-222222,-1|17|B5C7DE-222222,10|17|426D94-222222,-1|-14|94E3FF-222222"}
    local color_wcytl={"一条龙完成一轮",753,300,846,429,"FFFFFF-101010","-12|-4|FFFFFF-101010,-5|3|FFFFFE-101010,16|-3|F7F3EE-101010,9|1|EEA231-101010,7|-97|DDEEFE-101010,20|-97|D5F2F6-101010,20|-103|DDF2F6-101010"}
    local dragon_fb_flag={"副本中标志:",828,107,882,156,"EEC24A-101010","0|-4|FFF394-101010,4|-9|CE9221-101010,8|-5|D6DBAD-101010,-1|11|EEDF63-101010,17|24|944508-101010"}
    while(true) do
        Sleep(1000)
        if(mFindMultiColorNoTap(color_getTask)) then
            if(DRAGON_COUNT>=DragonMaxCount) then
                tap(200,577)
                return true
            else
                mFindMultiColor(color_getTask)
                DRAGON_COUNT=DRAGON_COUNT+1
                Sleep(1000)
                tap(200,577)
                tap(200,577)
            end
        end
        --副本中
        if(mFindMultiColorNoTap(dragon_fb_flag))then
            INTO=0
            DRAGON_NOFIND_COUNT=0
            mFindMultiColor(automatic)
            Sleep(1000)
            cleanBag()
            Sleep(1000)
            --每局开启自动匹配
            openTeamBar()
            Sleep(2000)
            if(mFindMultiColorNoTap(color_applylistbar_selected)) then
                --队伍申请界面
                tap(197,353)
                Sleep(2000)
                mFindMultiColor(color_acceptjoin)
                if(mFindMultiColor(color_teaminfobar_unselected)) then
                    --切回队伍信息栏
                    mMessageBoxEx("队伍信息..",2000)
                end
            end
            mFindMultiColor(color_auto_match)
            mFindMultiColor(color_window_close)
            Sleep(2000)
            --切回任务栏
            mFindMultiColor(color_taskbar_off)
            while(true) do
                mTracePrint("副本中..")
                mTracePrint("一条:第"..DRAGON_COUNT.."轮")
                if(mFindMultiColor(color_revive)) then
                    Sleep(1000)
                    mFindMultiColor(automatic)
                end
                --拒绝队长申请
                if(mFindMultiColor(color_deny)) then
                    mMessageBoxEx("取消..",2000)
                end
                mFindMultiColor(color_use)
                --完成一轮
                if(mFindMultiColorNoTap(color_wcytl))then
                    mTracePrint("完成一轮,当前第"..DRAGON_COUNT.."轮")
                    if(DRAGON_COUNT>=DragonMaxCount)then
                        mMessageBoxEx("已完成"..DRAGON_COUNT.."轮一条,结束任务...",2000)
                        return true
                    else
                        mFindMultiColor(color_wcytl)
                    end
                    Sleep(6000)
                    while(true) do
                        if(mFindMultiColor(color_getTask))then
                            NotFindCount=0
                            DRAGON_COUNT=DRAGON_COUNT+1
                            mFindMultiColorAppear(color_talk,true,2000)
                            tap(200,577)
                            break
                        else
                            mMessageBoxEx("等待重新接取..",2000)
                            NotFindCount=NotFindCount+1
                            if(NotFindCount>=10) then
                                if(getDragonTask()) then
                                    NotFindCount=0
                                    break
                                end
                            end
                            Sleep(3000)
                        end
                    end
                end
                if(mFindMultiColorNoTap(dragon_fb_flag)) then
                    mMessageBoxEx("一条:第"..DRAGON_COUNT.."轮",2000)
                    Sleep(2000)
                else
                    break
                end
            end
        end
        --副本外
        if(mFindMultiColor(color_doDragon)) then
            DRAGON_NOFIND_COUNT=0
            Sleep(1000)
            mTracePrint("副本外..")
            if(mFindMultiColor(color_dragon_in)) then
                INTO=INTO+1
                Sleep(4000)
                mMessageBoxEx("INTO.."..INTO,1500)
            end
        else
            DRAGON_NOFIND_COUNT=DRAGON_NOFIND_COUNT+1
            mFindMultiColor(color_window_close)
            --切回任务栏
            mFindMultiColor(color_taskbar_off)
            mMessageBoxEx("NOTFIND:"..DRAGON_NOFIND_COUNT,2000)
            if((DRAGON_NOFIND_COUNT>=5)) then
                getDragonTask()
                Sleep(5000)
            end
            Sleep(4000)
        end
        --拉跟随
        if(not mFindMultiColorNoTap(dragon_fb_flag)) then
            if(INTO>=4) then
                --打开队伍信息栏
                mMessageBoxEx("召唤队友跟随...",1000)
                if(mFindMultiColor_offset(color_taskbar_on,100,0))then
                    mTracePrint("任务栏......................")
                    Sleep(3000)
                    mFindMultiColor(color_teambar_unselected)
                    Sleep(3000)
                    mFindMultiColor(color_teambar_unselected)
                end
                if(mFindMultiColor(color_call_follow))then
                    INTO=0
                    mFindMultiColor(color_auto_match)
                    mFindMultiColor(color_window_close)
                    Sleep(2000)
                end
                --切回任务栏
                mFindMultiColor(color_taskbar_off)
            end
        end
        Sleep(2000)
    end
end
function openTeamBar()
    --打开队伍信息面板
    if(mFindMultiColor_offset(color_taskbar_on,100,0))then
        mTracePrint("任务栏......................")
        Sleep(2000)
        mFindMultiColor(color_teambar_unselected)
        Sleep(2000)
        mFindMultiColor(color_teambar_unselected)
    end
end
----------------------------
function doZlT()
    local isBackUp=-1
    local color_citanTask={"刺探任务",55,199,119,275,"F7C200-101010","4|9|F7C200-101010,8|11|F7C200-101010,12|17|F7C200-101010,19|17|EEBA08-101010,26|14|EEBE08-101010,26|5|F6C600-101010,24|0|E6BA08-101010"}
    local color_zltTaskFlag={"接取战龙堂任务",977,144,1037,511,"42E3EF-101010","6|1|29D7E7-101010,3|9|21BAD6-101010,-2|12|18B2CE-101010,-4|20|10D7E7-101010,1|22|21344A-101010,-7|12|213042-101010"}
    local color_zltSubmit={"提交任务",977,144,1037,511,"398AC6-101010","6|0|29E3EF-101010,0|-12|63E7EF-101010,0|5|4AE7EF-101010,-7|2|29E3EF-101010,-10|-8|182C39-101010,-7|-12|21344A-101010"}
    local zlt_timeleft={"战龙剩余时间",64,195,155,437,"00FF00-111111","1|0|00FB00-111111,0|1|00FF00-111111,1|1|00FB00-111111,0|9|00EF00-111111,1|9|00E300-111111"}
    local color_zltconfirm={"ZLT确任完成五次",610,393,642,439,"F7FBFF-111111","-8|3|214573-111111,-9|8|B5C7D6-111111,-2|12|8CA2BD-111111,-2|-10|94E7FF-111111"}
    local color_citan={"刺探完成-绿:",69,194,176,304,"10BA00-101010","-4|11|10BE00-101010,7|17|10C700-101010,14|16|10BA00-101010,21|7|21A208-101010,24|-1|10C700-101010,31|16|29A610-101010,-24|16|E7B600-101010,-48|0|FFC700-101010"}
    local ctml={"密令",1018,401,1079,487,"F7FBFF-101010","11|-2|6BB6E7-101010,11|-5|FFFFFF-101010,25|1|FFFFFF-101010,1|-17|9CEBFF-101010,0|-34|A5F3FF-101010,2|-48|ADF7FF-101010,-9|-53|ADFBFF-101010,16|-36|9CE3E7-101010,21|-44|9CE7EF-101010"}
    if(mFindMultiColorNoTap(zlt_timeleft)) then
        mTracePrint("刺探中..")
        if(mFindMultiColor(automatic))then
            while(true) do
                if(mFindMultiColor(color_zltSubmit)) then
                    Sleep(500)
                    mFindMultiColor(color_talk)
                    Sleep(500)
                    mFindMultiColor(color_talk)
                end	
                --死亡放弃任务
                if(mFindMultiColor(color_revive)) then
                    isBackUp=0
                end
                if(isBackUp==0) then
                    mMessageBoxEx("挑战失败,重接任务....",2000)
                    Sleep(2000)
                    backupTask()
                    break
                end
            end
        end
    end
    -------------
    if(mFindMultiColor(color_zltTaskFlag))then
        isBackUp=-1
        Sleep(500)
        mFindMultiColor(color_talk)
    elseif(mFindMultiColor(color_zltSubmit))then
        isAutoMatic=1
        Sleep(500)
        mFindMultiColor(color_talk)
    elseif(mFindMultiColor(color_do_zl)) then
        Sleep(500)
        mFindMultiColor(color_talk)
        Sleep(500)
        if(mFindMultiColor(color_use))then
            Sleep(5000)
        end
    else
        if(mFindMultiColor(color_zltconfirm)) then
            mMessageBoxEx("完成全部战龙堂...",2000)
            return true
        end
        if(getZLT()==0)then
            mMessageBoxEx("等待接取任务...",2000)
            mTracePrint("重新接取成功")
        end
        mFindMultiColor(color_window_close)
    end
end
function getZLT()
    --0:接取成功
    --1:已全部完成任务
    ---1 接取失败
    local color_zltComplete={"战龙堂end..",280,80,1190,630,"FFFBFF-111111","2|-7|FFFFFF-111111,-190|-25|424542-111111,-188|-15|DEE3E7-111111,-217|-22|5A6973-111111,-220|-35|D6DFE7-111111"}
    local color_zltTaskFlag={"接取战龙堂任务",977,144,1037,511,"42E3EF-101010","6|1|29D7E7-101010,3|9|21BAD6-101010,-2|12|18B2CE-101010,-4|20|10D7E7-101010,1|22|21344A-101010,-7|12|213042-101010"}
    mMessageBoxEx("getZLT..",2000)
    mFindMultiColor(color_window_close)
    if(mFindMultiColor(color_do_zl)) then
        mMessageBoxEx("已接取战龙堂..",2000)
        return 0
    else
        if(mFindMultiColor(color_activity)) then
            mMessageBoxEx("活动面板",2000)
            Sleep(2000)
            mFindMultiColor(dailyBar)
        end
        Sleep(1000)
        if(mFindMultiColor_offset(dailyBarSelected,620,-70)) then
            mTracePrint("我要帮贡")
            Sleep(1000)
            if(mFindMultiColorNoTap(color_zltComplete))then
                mMessageBoxEx("战龙堂全部完成...",1000)
                mFindMultiColor(color_windowlist[1])
                return 1
            elseif(mFindMultiColor(color_joinZLT)) then
                mFindMultiColorAppear(color_zltTaskFlag,true,2000)
                return 0
            end
        end
    end
    return -1
end
function startZLT()
    while(true) do
        local ret=getZLT()
        if(ret==0) then
            break
        elseif(ret==1) then
            return
        end
    end
    while(true) do
        if(doZlT())then
            mMessageBoxEx("完成全部战龙堂...",1500)
            break
        end
    end
end
function startBT()
    --宝图任务
    local BT_NOTFOUNT_COUNT=0
    local btfb_flag={"宝图副本标志",1055,101,1112,160,"9CEF3A-101010","-8|-15|FFFF52-101010,-21|11|21CAFF-101010,-10|3|6BDB08-101010,-23|16|31C2EE-101010,-28|16|EEC610-101010,-7|23|FFFFFF-101010"}
    local color_doBT={"执行宝图",8,192,59,451,"F7C300-202020","-21|-3|EFBA00-202020,-27|4|F7C300-202020,-14|13|FFC700-202020,-6|15|FFC700-202020,0|6|F7C300-202020,4|9|EFBE00-202020,7|15|E7B200-202020"}
    local at=timenow()
    local tw=timeweek(at)
    mMessageBoxEx("当前时间:"..at.."  星期"..tw,2000)
    Sleep(2000)
    tw=tonumber(tw)
    if(tw==2 or tw==4 or tw==6) then
        mMessageBoxEx("开始宝图任务...",2000)
    else
        mMessageBoxEx("时间错误,结束宝图任务..",2000)
        return
    end
    if(mFindMultiColor(color_doBT)) then
        mMessageBoxEx("已经接取宝图..",1000)
        Sleep(2000)
    else
        while(true) do
            local ret=getBT()
            if(ret==1)then
                break
            elseif(ret==0) then
                mMessageBoxEx("宝图已完成..",2000)
                closeAllWindow()
                return true
            end
        end
    end
    while(true) do
        if(mFindMultiColor(color_doBT))then
            BT_NOTFOUNT_COUNT=0
            Sleep(4000)
        else
            mFindMultiColor(color_talk)
            BT_NOTFOUNT_COUNT=BT_NOTFOUNT_COUNT+1
            if(BT_NOTFOUNT_COUNT>=4) then
                if(getBT()==0)then
                    mMessageBoxEx("已完成宝图..",1000)
                    return true
                end
            end
            Sleep(4000)
        end
        if(mFindMultiColorNoTap(btfb_flag)) then
            mFindMultiColor(automatic)
            while(true) do
                if(mFindMultiColor(color_revive))then
                    countDown("复活回血..",5)
                    mFindMultiColor(automatic)
                end
                if(mFindMultiColor(color_leaveFB)) then
                    mMessageBoxEx("离开副本..",1500)
                    Sleep(5000)
                    break
                end
                if(mFindMultiColorNoTap(btfb_flag)) then
                    mMessageBoxEx("副本中..",2000)
                    Sleep(2000)
                else
                    break
                end
            end
        end
    end
end
function getBT()
    mMessageBoxEx("getBT",2000)
    local completeBt2={"宝图完成2:",366,493,682,618,"FFFFFF-101010","0|11|FFFFFF-101010,7|17|FFFFFF-101010,10|19|F7F7FF-101010,20|6|F7F3F7-101010,29|10|FFFBFF-101010,29|19|FFFFFF-101010,75|12|FFFFFF-101010,244|27|949294-101010,254|48|8C8A8C-101010"}
    local completeBt={"宝图完成:",333,182,1171,646,"8C8A8C-101010","0|-11|949294-101010,-208|-30|FFFFFF-101010,-217|-34|F7F7F7-101010,-217|-38|F7F3F7-101010,-234|-24|F7F7F7-101010,-166|-35|FFFFFF-101010,-158|-39|FFFFFF-101010,-158|-21|FFFFFF-101010"}
    local color_joinBT={"参加宝图..",333,80,1171,646,"2979BD-202020","5|-3|FFFFFF-202020,-241|-27|FFFFFF-202020,-238|-33|EFF3F7-202020,-251|-37|FFFBFF-202020,-265|-28|FFFFFF-202020,-260|-24|E7EBEF-202020,-261|-41|FFFFFF-202020"}
    Sleep(2000)
    if(mFindMultiColor(color_activity))then
        Sleep(1000)
        if(mFindMultiColor(dailyBar)) then
            Sleep(2000)
            if(mFindMultiColor(color_joinBT)) then
                mMessageBoxEx("参加宝图...",1000)
                Sleep(5000)
                return 1
            else
                swipe(577,627,575,180)
                Sleep(1000)
                swipe(577,627,575,180)
                Sleep(2000)
                if(mFindMultiColorNoTap(completeBt))then
                    mFindMultiColor(color_windowlist[1])
                    return 0
                elseif(mFindMultiColorNoTap(completeBt2)) then
                    mFindMultiColor(color_windowlist[1])
                    return 0
                end
            end
        end
    else
        mFindMultiColor(color_window_close)
    end 
end
function homeTask()
    local color_gohome={"回家",980,628,1010,667,"FFFFFF-111111","-6|3|522408-111111,-6|-2|BD7D39-111111,-6|-7|FFDFB5-111111,-9|-9|4A2008-111111,3|4|CE7D10-111111"}
    local color_map_homebar={"地图-家园面板",128,533,151,552,"6B6DBD-111111","0|2|D6DFF7-111111,0|4|84AEB5-111111,-1|5|5A599C-111111,-4|5|8C92E7-111111,3|7|F7F7FF-111111"}
    local color_homebar={"家园面板",953,648,980,676,"7B8EE7-111111","-3|0|6361AD-111111,-3|2|EFF3F7-111111,-4|2|84AAB5-111111,-5|3|524984-111111,-6|4|8C92E7-111111"}
    while(true) do
        ATHOME=0
        Sleep(3000)
        if(mFindMultiColor(color_map_homebar) and ATHOME==0)then
            Sleep(3000)
            athome=1
        end
        if(mFindMultiColor(color_point))then
            if(mFindMultiColor_offset(color_pointX,90,0))then
                mMessageBoxEx("X",1000)
            end
            Sleep(4000)
            if(mFindMultiColor_offset(color_pointY,90,0)) then
                mMessageBoxEx("y",1000)
            end
        end
        --人物坐标
        --苗圃坐标
        local nur1x = editgettext("nursery_1x")
        local nur1y = editgettext("nursery_1y")
        local nur2x = editgettext("nursery_2x")
        local nur2y = editgettext("nursery_2y")
        local nur3x = editgettext("nursery_3x")
        local nur3y = editgettext("nursery_3y")
        local nur4x = editgettext("nursery_4x")
        local nur4y = editgettext("nursery_4y")
        local nur5x = editgettext("nursery_5x")
        local nur5y = editgettext("nursery_5y")
        local nur6x = editgettext("nursery_6x")
        local nur6y = editgettext("nursery_6y")
        nur1x=tonumber(nur1x)
        nur1y=tonumber(nur1y)
        nur2x=tonumber(nur2x)
        nur2y=tonumber(nur2y)
        nur3x=tonumber(nur3x)
        nur3y=tonumber(nur3y)
        nur4x=tonumber(nur4x)
        nur4y=tonumber(nur4y)
        nur5x=tonumber(nur5x)
        nur5y=tonumber(nur5y)
        nur6x=tonumber(nur6x)
        nur6y=tonumber(nur6y)
        nurlistX={nur1x,nur2x,nur3x,nur4x,nur5x,nur6x}
        nurlistY={nur1y,nur2y,nur3y,nur4y,nur5y,nur6y}
        pointX={}
        pointY={}
        --X坐标输出顺序
        for i=1,#pointX do
            for j=1,#pointX[i] do
                traceprint("pointX:"..pointX[i][j])
            end
        end
    end
end
--检查守财奴时间
function checkMiser()
    local gotoMiser={"前往",828,197,895,231,"FFFFFF-101010","4|-1|DE8618-101010,14|-4|844D18-101010,17|-12|FFEFD6-101010,25|-15|FFEFD6-101010,27|-5|FFFFFF-101010,31|-4|E78E18-101010,38|-17|FFF7F7-101010"}
    MiserDestID=-1
    nowTime()
    if(nowHour>=13) then
        --任务时间内
        if(nowMinute>=58)then
            --兰若寺
            MiserDestID=0
        elseif(nowMinute >= 13 and nowMinute < 17) then
            --黑风洞
            MiserDestID=1
        elseif(nowMinute >= 28 and nowMinute < 32)then
            --兰若地宫
            MiserDestID=2
        elseif(mFindMultiColorNoTap(miserLogo2))then
            --时间判断
            return true
        end
    end
    mTracePrint("MiserDestID.."..MiserDestID)
    if(MiserDestID~=-1) then
        return true
    end
    return false
end
--处理坐标数据
function handlePointData(x,y)
    local retX={}
    local retY={}
    local X={}
    local Y={}
    ---------------------------------------  
    while ( x > 0) do
        mdata=math.floor(x/10);
        t1=x%10 
        x=mdata
        table.insert(retX,table.maxn(retX) + 1,t1)
    end
    while ( y > 0) do
        mdata=math.floor(y/10);
        t2=y%10 
        y=mdata
        table.insert(retY,table.maxn(retY) + 1,t2)
    end
    for i=#retX,1,-1 do
        table.insert(X,#X + 1,retX[i])
    end
    for i=#retY,1,-1 do
        table.insert(Y,#Y + 1,retY[i])
    end
    return  X,Y
end
--设置地图坐标,并前往
function setMapPoint(PointX,PointY)
    local index=-1
    local openMap={"打开地图",1128,197,1191,245,"DE5D21-101010","-13|12|FFFBBD-101010,12|5|FFFFD6-101010,12|17|422000-101010,14|16|4A2808-101010,-18|8|FFFBCE-101010"}
    local color_point={"打开坐标系",334,42,391,93,"F7CB39-101010","0|-10|214D73-101010,12|-10|FFD34A-101010,8|-20|FFDB6B-101010,8|-2|F7C721-101010,-13|-9|FFEFC6-101010,-6|-10|183C5A-101010,-21|-1|295D84-101010"}
    local goto={"前往坐标..",761,399,823,434,"FFFBF7-101010","-2|10|DE8210-101010,-6|5|BD9E7B-101010,-12|3|FFFFFF-101010,-9|-8|CEBEB5-101010,7|-6|FFF7EF-101010,7|4|E78E18-101010,4|4|845D39-101010"}
    local cancelGoto={"取消前往",456,396,517,432,"FFFFFF-101010","0|-5|FFFFFF-101010,11|3|FFFFFF-101010,11|-4|63AEE7-101010,11|-13|94D3F7-101010,11|10|317DBD-101010,2|10|E7EFF7-101010"}
    --偏移90
    local X_flag={"xFlag:",465,318,485,344,"FFFFFF-111111","-2|-2|42556B-111111,-3|4|F7FBFF-111111,3|4|FFFFFF-111111,3|-3|42556B-111111,3|-5|FFFFFF-111111"}
    local Y_flag={"yFlag:",646,315,666,344,"7B8694-111111","3|-3|FFFFFF-111111,-2|-4|A5AAB5-111111,0|4|EFEFF7-111111,0|8|EFEFF7-111111,3|-5|8C92A5-111111"}
    --坐标输入键盘0-9 确认键
    local offset_x=185
    local keyboardX_confirm={x=914,y=457}
    local keyboardY_confirm={x=914+offset_x,y=457}
    local keyboard_X={{x=957,y=328},{x=683,y=203},{x=779,y=203},{x=868,y=203},{x=684,y=292},{x=777,y=292},{x=868,y=292},{x=684,y=374},{x=777,y=374},{x=868,y=374}}
    local keyboard_Y={{x=957+offset_x,y=328},{x=683+185,y=203},{x=779+185,y=203},{x=868+185,y=203},{x=684+offset_x,y=292},{x=777+offset_x,y=292},{x=868+offset_x,y=292},{x=684+offset_x,y=374},{x=777+offset_x,y=374},{x=868+offset_x,y=374}}
    if(mFindMultiColor_offset(openMap,0,-100))then
        Sleep(2000)
        if(mFindMultiColor(color_point)) then
            Sleep(1500)
        else
            mTracePrint("color_point not find")
        end
    else
        mFindMultiColor(color_window_close)
    end
    --输入界面
    if(mFindMultiColorNoTap(goto))then
        mTracePrint("输入界面")
        --输入X坐标
        if(mFindMultiColor_offset(X_flag,90,0)) then
            Sleep(1000)
            for i=1,#PointX,1 do
                index=PointX[i]+1
                tap(keyboard_X[index].x,keyboard_X[index].y)
                Sleep(1000)
            end
            tap(keyboardX_confirm.x,keyboardX_confirm.y)
        end
        Sleep(2000)
        --输入Y坐标
        if(mFindMultiColor_offset(Y_flag,90,0)) then
            Sleep(1000)
            for i=1,#PointY,1 do
                index=PointY[i]+1
                tap(keyboard_Y[index].x,keyboard_Y[index].y)
                Sleep(1000)
            end
            tap(keyboardY_confirm.x,keyboardY_confirm.y)
        end
        Sleep(2000)
        if(mFindMultiColor(goto)) then
            Sleep(5000)
            if(mFindMultiColorNoTap(goto)) then
                mMessageBoxEx("坐标无法到达..",2000)
                mTracePrint("坐标无法到达")
                --关闭界面
                if(mFindMultiColor(cancelGoto)) then
                    Sleep(1000)
                    mFindMultiColor(color_windowlist[1])
                end
                return false
            else
                mFindMultiColor(color_windowlist[1])
                return true
            end
        end
    end
end
function onHook()
    mTracePrint("HookMap:"..HookMapId.." "..HookPointX.." "..HookPointY)
    if(goDest(HookMapId))then
        Sleep(5000)
        while(true) do
            if(mFindMultiColorNoTap(shrinkBar))then
                break
            else
                mFindMultiColor(color_window_close)
                Sleep(5000)
            end
        end
        mPointX,mPointY=handlePointData(HookPointX,HookPointY)
        if(setMapPoint(mPointX,mPointY))then
            countDown("前往坐标点..",20)
            mTracePrint("前往坐标点20S")
            if(mFindMultiColor(automatic))then
                mMessageBoxEx("开始挂机..",2000)
                if(mFindMultiColor_offset(color_taskbar_on,100,0)) then
                    Sleep(1000)
                end
                mFindMultiColor(cancelFollow)
                return true
            end
        else
            mMessageBoxEx("请重新设置挂机坐标..",2000)
            return false
        end
    else
        closeAllWindow()
    end
end
--目的地
function goDest(dest)
    local openMap={"打开地图",1128,197,1191,245,"DE5D21-101010","-13|12|FFFBBD-101010,12|5|FFFFD6-101010,12|17|422000-101010,14|16|4A2808-101010,-18|8|FFFBCE-101010"}
    local wordmap={"切到世界地图",227,54,289,113,"8CF321-101010","11|0|8CF321-101010,-5|20|8CF321-101010,-10|20|84EB21-101010,3|37|5296C6-101010,-20|12|295984-101010,-16|8|FFCF84-101010,11|25|FFEFA5-101010"}
    local map_lrs={"兰若寺",603,329,631,403,"7B1C08-101010","8|3|EFDBBD-101010,11|8|F7E7C6-101010,6|11|E7CBAD-101010,6|6|B57963-101010,9|-6|7B1C08-101010,7|-7|C6927B-101010"}
    local map_hfd={"黑风洞",666,510,691,572,"F7E3C6-101010","5|-5|FFEBCE-101010,10|0|F7E7C6-101010,5|13|FFEBC6-101010,11|19|FFEBC6-101010,-2|19|F7E7C6-101010,5|10|7B1C08-101010,5|-1|7B1C08-101010"}
    local map_lrdg={"兰若地宫",466,307,494,376,"F7E3BD-101010","3|1|EFD7B5-101010,6|4|8C3018-101010,-2|5|7B1C08-101010,0|11|D6B294-101010,3|17|AD6D52-101010,5|21|F7DFBD-101010,-7|15|F7E7C6-101010"}
    local map_dsg={"兜率宫",450,118,472,160,"E6CEAC-101010","0|7|E6C6A4-101010,4|7|EED6B5-101010,-4|13|F6E6C5-101010,-5|11|7B1C08-101010,6|11|7B2010-101010,0|19|DEC2A4-101010"}    
    local map_dy={"地狱",259,501,285,551,"F7E3BD-101010","6|1|FFEFCE-101010,13|9|EEDBB5-101010,3|9|7B1C08-101010,13|0|FFEBC5-101010,13|-4|7B1C08-101010,6|-4|7B1C08-101010"}
    local map_hq={"黄泉",387,413,414,465,"EFD7B5-101010","0|6|FFEFCD-101010,-4|11|F7E7C5-101010,-1|17|7B1C08-101010,-1|21|E6CEAD-101010,-4|28|FFEACD-101010,-7|27|7B1C08-101010"}
    local map_wc={"忘川",527,496,556,557,"F7EFC5-101010","1|35|EED6B5-101010,8|35|E6CAAD-101010,6|14|EEDFBD-101010,1|12|EEDFBD-101010,0|15|7B2010-101010,-7|16|7B1C08-101010"}
    local map_slgd={"丝路古道",320,265,343,330,"7B1C08-101010","-1|14|7B1C08-101010,0|29|7B1C08-101010,0|32|E7CBAD-101010,6|18|EFD7B5-101010,6|7|7B1C08-101010,-7|24|EFD7B5-101010"}
    local map_tg={"天宫",531,200,558,238,"E6CAAD-101010","0|5|DEC2A4-101010,-4|15|EEDBBD-101010,5|14|FFEFC5-101010,5|-1|7B1C08-101010,-6|12|7B1C08-101010,-6|-7|FFEBC5-101010,8|-6|F6E2BD-101010"}
    local gotoMiser={"前往",828,197,895,231,"FFFFFF-101010","4|-1|DE8618-101010,14|-4|844D18-101010,17|-12|FFEFD6-101010,25|-15|FFEFD6-101010,27|-5|FFFFFF-101010,31|-4|E78E18-101010,38|-17|FFF7F7-101010"}
    --取消挂机
    closeAllWindow()
    if(mFindMultiColor(cancelAutoMaitc)) then
        mMessageBoxEx("取消挂机..",2000)
    end
    --有标志直接飞
    if(mFindMultiColor(miserLogo2)) then
        Sleep(1000)
        if(mFindMultiColor(gotoMiser)) then
            return true
        end
    end
    --提前去等待
    if(mFindMultiColor_offset(openMap,0,-100)) then
        Sleep(2000)
        if(mFindMultiColor(wordmap)) then
            Sleep(2000)
            if(dest==0) then
                mMessageBoxEx("兰若寺..",1500)
                if(mFindMultiColor(map_lrs)) then
                    return true
                end
            elseif(dest==1) then
                mMessageBoxEx("黑风洞..",1500)
                if(mFindMultiColor(map_hfd)) then
                    return true
                end
            elseif(dest==2) then
                mMessageBoxEx("兰若地宫",1500)
                if(mFindMultiColor(map_lrdg)) then
                    return true
                end
            elseif(dest==3) then
                mMessageBoxEx("兜率宫",1500)
                if(mFindMultiColor(map_dsg)) then
                    return true
                end
            elseif(dest==4) then
                mMessageBoxEx("地狱",1500)
                if(mFindMultiColor(map_dy)) then
                    return true
                end
            elseif(dest==5) then
                mMessageBoxEx("黄泉",1500)
                if(mFindMultiColor(map_hq)) then
                    return true
                end
            elseif(dest==6) then
                mMessageBoxEx("忘川",1500)
                if(mFindMultiColor(map_wc)) then
                    return true
                end
            elseif(dest==7) then
                mMessageBoxEx("丝路古道",1500)
                if(mFindMultiColor(map_slgd))then
                    return true
                end
            elseif(dest==8) then
                mMessageBoxEx("天宫",1500)
                if(mFindMultiColor(map_tg))then
                    return true
                end
            end
            Sleep(5000)
        else
            closeAllWindow()
        end
    end
    return false
end
--清理包裹
function cleanBag()
    local close_bag_window={"关闭包裹:",1126,23,1156,48,"FFFFFF-101010","-6|0|314D63-101010,-2|-5|5A718C-101010,5|0|84A6B5-101010,2|-2|FFFFFF-101010,-7|-1|102C4A-101010"}
    local bag_recovery_confirm={"确认包裹回收", 1015,95,1078,131,"EFF7FF-101010","-3|11|215D94-101010,-5|13|FFFFFF-101010,2|6|395984-101010,2|0|EFF3FF-101010,2|-5|7B96B5-101010"}
    local blue_weapon={"勾选",765,99,858,132,"102031-101010","34|-2|ADF7FF-101010,38|-11|31516B-101010,36|3|ADF3FF-101010,46|3|ADFBFF-101010,48|-8|42657B-101010"}
    local bag_recovery={"包裹回收",913,92,982,132,"FFFFFF-101010","-4|-4|214573-101010,-5|7|B5C3D6-101010,1|-11|8CCBEF-101010,1|0|FFFFFF-101010,1|13|F7FBFF-101010"}
    local bag={"打开包裹",1128,197,1191,245,"DE5D21-101010","-13|12|FFFBBD-101010,12|5|FFFFD6-101010,12|17|422000-101010,14|16|4A2808-101010,-18|8|FFFBCE-101010"}
    if(mFindMultiColor(bag)) then
        Sleep(3000)
        mFindMultiColor(bag_recovery)
        Sleep(2000)
        if(mFindMultiColor(blue_weapon)) then
            Sleep(1000)
            if(mFindMultiColor(bag_recovery_confirm))then
                mMessageBoxEx("清理包裹...",2000)
                Sleep(1000)
                mFindMultiColor(close_bag_window)
                return true
            end
        end
    end
    Sleep(2000)
    mFindMultiColor(close_bag_window)
    return false
end
--检查队伍人数
function checkTeamNum(num)
    local peopleCount5={"队伍人数5: ",210,388,234,420,"FFFBEF-101010","-7|-10|FFFFFF-101010,-6|10|F7EB9C-101010,-2|1|FFFBE7-101010,-3|7|F7EBAD-101010,-3|-6|FFFFFF-101010"}
    local peopleCount4={"队伍人数4: ",206,328,234,360,"FFFBEF-101010","-7|-10|FFFFFF-101010,-6|10|F7EB9C-101010,-2|1|FFFBE7-101010,-3|7|F7EBAD-101010,-3|-6|FFFFFF-101010"}
    local peopleCount3={"队伍人数3: ",209,266,234,300,"FFFBEF-101010","-7|-10|FFFFFF-101010,-6|10|F7EB9C-101010,-2|1|FFFBE7-101010,-3|7|F7EBAD-101010,-3|-6|FFFFFF-101010"}
    local peopleCount2={"队伍人数3: ",207,206,235,239,"FFFBEF-101010","-7|-10|FFFFFF-101010,-6|10|F7EB9C-101010,-2|1|FFFBE7-101010,-3|7|F7EBAD-101010,-3|-6|FFFFFF-101010"}
    if(mFindMultiColor_offset(color_taskbar_on,100,0)) then
        Sleep(2000)
    end
    if(num==5) then
        if(mFindMultiColorNoTap(peopleCount5))then
            return true
        end
    elseif(num==4)then
        if(mFindMultiColorNoTap(peopleCount4))then
            return true
        end
    elseif(num==3)then
        if(mFindMultiColorNoTap(peopleCount3))then
            return true
        end
    elseif(num==2)then
        if(mFindMultiColorNoTap(peopleCount2))then
            return true
        end
    else
        return false
    end
end
--拉附近玩家入队
function nearOfPeople()
    local InvitePeople=0
    local color_create_team={"创建队伍",826,633,955,665,"FFFFFF-222222","2|-11|BDCBD6-222222,5|-5|7B92AD-222222,7|3|BDCBD6-222222,14|0|DEDFE7-222222"}
    local openInvite={"打开队伍邀请",1055,95,1096,134,"FFEFB5-101010","0|-14|EFBA63-101010,-8|-14|FFFFFF-101010,-8|7|F7E79C-101010,-8|10|CE7D18-101010,-12|-11|FFFFFF-101010"}
    local friends={"选泽好友",1040,160,1105,201,"FFFFFF-101010","-1|-2|4A9AD6-101010,4|-2|FFFFFF-101010,7|-1|BDCBDE-101010,7|-11|FFFFFF-101010,7|-17|8CCBF7-101010,22|8|FFFFFF-101010"}
    local nearPeople={"选泽附近的人",1015,222,1080,263,"FFFFFF-101010","-3|8|6B829C-101010,3|8|FFFFFF-101010,6|22|F7F7FF-101010,16|19|FFFFFF-101010,13|10|4A96D6-101010,20|2|63AEDE-101010,26|1|FFFFFF-101010"}
    local np={"附近玩家:",803,157,891,534,"F7F3F7-101010","-4|3|63AADE-101010,0|9|DEEBF7-101010,0|18|3179BD-101010,7|14|EFF3F7-101010,7|1|FFFFFF-101010"}
    local closeNpWindow={"关闭邀请面板",937,105,974,132,"FFFFFF-101010","-6|0|314D63-101010,-2|-5|5A718C-101010,5|0|84A6B5-101010,2|-3|FFFFFF-101010,-4|-3|FFFFFF-101010"}
    closeAllWindow()
    while(true) do
        if(mFindMultiColor_offset(shrinkBar,-100,0)) then
            Sleep(1000)
        else
            break
        end
    end
    Sleep(1000)
    if(mFindMultiColor(color_create_team)) then
        Sleep(1000)
    else
        mTracePrint("nop:已存在队伍")
    end
    if(mFindMultiColor(openInvite)) then
        Sleep(1000)
        if(mFindMultiColor(nearPeople)) then
            Sleep(1000)
            while(true) do
                if(mFindMultiColor(np)) then
                    InvitePeople=InvitePeople+1
                    if(InvitePeople>=4)then
                        InvitePeople=0
                        swipe(610,517,606,179)
                        Sleep(2000)
                    end
                else
                    break
                end
                Sleep(1000)
            end
            Sleep(1000)
            if(mFindMultiColor(closeNpWindow))then
                Sleep(1000)
                mFindMultiColor(color_windowlist[3])
            end
        end
    end
end
--喊话
function shout()
    local bhChannel={"帮会频道:",24,98,77,129,"FFFFFF-101010","10|-1|FFFFFF-101010,24|5|F7F7FF-101010,22|14|FFFFFF-101010,12|11|FFFFFF-101010,7|7|FFFFFF-101010,11|3|EFF3FF-101010"}
    local worldChannel={"世界频道",25,29,77,61,"FFFFFF-101010","15|0|F7FBFF-101010,10|7|FFFFFF-101010,9|12|E7EFF7-101010,24|12|F7FBFF-101010,23|2|F7F7F7-101010,29|-4|FFFFFF-101010"}
    local sendMessage={"发送消息",403,643,550,679,"FFFFFF-101010","-20|2|FFFFFF-101010,-25|-1|FFFFFF-101010,-16|-8|9CD7F7-101010,-42|-7|EFF3EF-101010,-42|6|529ACE-101010,-88|3|732410-101010,-106|0|F7F384-101010"}
    local confrimInput={"确认输入",1183,633,1248,671,"2D2D2D-101010","10|1|212121-101010,16|-11|212121-101010,1|-11|FFFFFF-101010,-9|10|FFFFFF-101010,-18|5|FFFFFF-101010,-21|-3|212121-101010"}
    local closeChatWindow={"关闭聊天窗口",583,341,618,396,"42A2D6-101010","-9|14|4AAEDE-101010,1|30|42A2D6-101010,-15|14|63CBEF-101010,-6|14|63CFEF-101010,3|-1|429ED6-101010,3|32|429ED6-101010"}
    if(mFindMultiColorNoTap(shrinkBar)) then
        tap(479,636)
    else
        mFindMultiColor(color_close_window)
    end
    Sleep(3000)
    if(mFindMultiColorNoTap(sendMessage)) then
        if(ShoutChannel==0) then
            if(not mFindMultiColor(worldChannel)) then
                tap(54,45)
            end
        elseif(ShoutChannel==1)then
            if(not mFindMultiColor(bhChannel)) then
                tap(51,115)
            end
        end
        Sleep(500)
        if(mFindMultiColor_offset(sendMessage,-300,0))then
            Sleep(1000)
            inputtext(ShoutContext)
            Sleep(1000)
            if(mFindMultiColor(confrimInput)) then
                Sleep(1000)
            end
            if(mFindMultiColor(sendMessage)) then
                traceprint("发送成功")
                Sleep(1000)
            end
        end
        if(mFindMultiColor(closeChatWindow)) then
            traceprint("关闭")
            return true
        end
    end
end
--无脑技能
function wnjn()
    for i=1,#SKILL_USE,1 do
        --traceprint("test "..SKILL_USE[i][1].." "..SKILL_USE[i][2])
        tap(SKILL_USE[i][1],SKILL_USE[i][2])
        Sleep(500)
    end
end
--采薇
function startCaiWei()
    local CaiWeiNFC=0
    local CWlogoDisCount=0
    local cwLogo={"薇标志",885,116,1119,157,"EFC3FF-101010","-4|6|CE79F7-101010,7|6|D67DFF-101010,15|7|D671FF-101010,9|-5|EFD7F7-101010,-1|-5|EFD7FF-101010,-9|-11|FFF3FF-101010,7|-13|FFFFFF-101010,1|-11|392810-101010"}
    local gotoCaiWei={"前往采薇",830,196,893,233,"FFFFFF-101010","0|12|FFFFFF-101010,11|12|DE8618-101010,11|-1|EF9E21-101010,11|-9|F7B64A-101010,27|4|FFFFFF-101010,33|4|FFFFFF-101010,31|12|FFFBF7-101010"}
    local intoCaiWei={"进入采薇副本",1088,467,1150,499,"FFFFFF-101010","-7|-5|FFFBFF-101010,-4|9|317DC6-101010,7|0|FFFFFF-101010,4|-7|6BB2E7-101010,8|-7|FFFFFF-101010,20|-10|EFF7FF-101010,16|7|3986C6-101010,28|7|FFFFFF-101010"}
    local closeCaiWeiWindow={"关闭采薇窗口",928,60,976,93,"FFFFFF-101010","-4|-3|FFFFFF-101010,3|-3|FFFFFF-101010,6|1|29415A-101010,-5|0|849EAD-101010,-2|-5|42617B-101010,-6|-5|FFFFFF-101010"}
    --检查队伍人数    while(true) do
        if(checkTeamNum(3)) then
            break
        else
            mTracePrint("采薇:队伍人数不足")
            return
        end
    end
    --召唤队友
    if(mFindMultiColor(callFollow)) then
        Sleep(1000)
        mTracePrint("开始采薇,召唤跟随")
    end
    if(goDest(CaiWeiDestID))then
        Sleep(5000)
    else
        mTracePrint("采薇传送失败:"..CaiWeiDestID)
        return false
    end
    --等待LOGO第一次出现
    mFindMultiColorAppear(cwLogo,false,2000)
    
    while(mFindMultiColor(cwLogo)) do
        --确认前往
        while(mFindMultiColorNoTap(cwLogo)) do
            if(mFindMultiColor(cwLogo))then
                Sleep(1000)
                if(mFindMultiColor(gotoCaiWei)) then
                    --过图时间可能找不到任务
                    Sleep(5000)
                    break
                else
                    mFindMultiColor(closeCaiWeiWindow)
                    Sleep(2000)
                end
            else
                break
            end
        end
        --等待进入副本
        while(true) do
            if(mFindMultiColor(intoCaiWei)) then
                Sleep(1500)
                while(mFindMultiColor(intoCaiWei)) do
                    mFindMultiColor(callFollow)
                    Sleep(2000)
                end
                break
            else
                CaiWeiNFC=CaiWeiNFC+2
                if(CaiWeiNFC>=40) then
                    if(mFindMultiColor(mFindMultiColor(cwLogo))) then
                        mMessageBoxEx("可能被抢,前往下个目标",1000)
                        mTracePrint("可能被抢,前往下个目标")
                        Sleep(1500)
                        if(mFindMultiColor(gotoCaiWei)) then
                            CaiWeiNFC=0
                        else
                            mFindMultiColor(closeCaiWeiWindow)
                        end
                    else
                        break
                    end
                elseif(CaiWeiNFC>=20) then
                    mMessageBoxEx("寻找采薇.."..CaiWeiNFC,1000)
                end
                Sleep(2000)
            end
        end
        --进入副本
        Sleep(5000)
        while(true) do
            if(mFindMultiColorNoTap(FbFlag)) then
                CWlogoDisCount=0
                if(mFindMultiColor(automatic))then
                    Sleep(1000)
                    mFindMultiColor(cancelFollow)
                end
            elseif(mFindMultiColorNoTap(cwLogo))then
                if(mFindMultiColor(callFollow)) then
                    break
                end
            else
                CWlogoDisCount=CWlogoDisCount+2
                if(CWlogoDisCount>=10) then
                    CWlogoDisCount=0
                    break
                end
            end
			Sleep(2000)
        end
    end
end
--守财奴
function startMiser()
    local TRE_NFC=0
    local MaticNFC=0
    local miserOver={"守财礼包",965,401,1100,480,"FFFFFF-101010","21|-4|8C9EB5-101010,9|-11|9CD7F7-101010,-24|-30|ADFBFF-101010,-48|-47|94DBDE-101010,-6|-35|A5EFF7-101010,15|-32|ADFBFF-101010,11|6|529AD6-101010,34|-5|FFFFFF-101010"}
    local gotoMiser={"前往",838,196,906,233,"FFFBF7-101010","0|-8|CE8A21-101010,-1|-15|FFEBEF-101010,-8|-20|E7EBEF-101010,-22|1|DE8210-101010,-28|0|FFFBFF-101010,3|4|D67D10-101010,3|-22|F7C35A-101010"}
    local closeMiserWindow={"关闭守财窗口",928,60,976,93,"FFFFFF-101010","-4|-3|FFFFFF-101010,3|-3|FFFFFF-101010,6|1|29415A-101010,-5|0|849EAD-101010,-2|-5|42617B-101010,-6|-5|FFFFFF-101010"}
    local treasure={"交出宝藏",1060,463,1180,499,"EFF3FF-101010","-4|-1|3182C6-101010,-8|-8|FFFFFF-101010,-13|-12|DEEFFF-101010,-18|-14|C6E3F7-101010,17|-2|FFFBFF-101010,-1|1|B5CFE7-101010,-3|-25|9CD7F7-101010"}
    local killMiser={"击杀守财奴",524,0,596,31,"E775E7-101010","10|-1|FF7DE7-101010,19|4|E71C21-101010,14|16|F72018-101010,28|15|FF8AFF-101010,38|15|FF2421-101010,40|4|EF1C18-101010,51|-1|FF82FF-101010"}
    --召唤队友
    if(mFindMultiColor(callFollow)) then
        Sleep(1000)
        mTracePrint("守财传送,召唤跟随")
    end
    if(goDest(MiserDestID))then
        Sleep(5000)
    else
        mTracePrint("守财传送失败:"..MiserDestID)
        return false
    end
    --等待LOGO第一次出现
    mFindMultiColorAppear(miserLogo2,false,2000)
    --等待LOGO消失
    while(mFindMultiColorNoTap(miserLogo2)) do
        mTracePrint("---------------守财:确认前往------------------------")
        Sleep(500)
        while(true) do
            if(mFindMultiColor(miserLogo2))then
                Sleep(1000)
                if(mFindMultiColor(gotoMiser)) then
                    --过图时间可能找不到任务
                    Sleep(5000)
                    break
                else
                    mFindMultiColor(closeMiserWindow)
                    Sleep(2000)
                end
            else
                break
            end
        end
        mTracePrint("---------------守财:赶路找怪------------------------")
        while(true) do
            if(mFindMultiColor(treasure)) then
                Sleep(2000)
                while(mFindMultiColor(treasure)) do
                    Sleep(2000)
                    mFindMultiColor(callFollow)
                end
                if(mFindMultiColor(automatic))then
                    Sleep(1000)
                    mFindMultiColor(cancelFollow)
                end
                TRE_NFC=0
                break
            else
                TRE_NFC=TRE_NFC+2
                mMessageBoxEx("TRE_NFC.."..TRE_NFC,1000)
                if(TRE_NFC>=30) then
                    mTracePrint("可能被抢了,寻找下一个",2000)
                    mMessageBoxEx("可能被抢了,寻找下一个",2000)
                    if(mFindMultiColor(miserLogo2))then
                        Sleep(1500)
                        if(mFindMultiColor(gotoMiser))then
                            TRE_NFC=0
                        else
                            mFindMultiColor(closeMiserWindow)
                        end
                    else
                        break
                    end
                elseif(TRE_NFC>=20)then
                    mMessageBoxEx("寻找守财奴.."..TRE_NFC,1000)
                end
                Sleep(2000)
            end
        end
        mTracePrint("---------------守财:战斗------------------------")
        while(true) do
            if(mFindMultiColor(miserOver)) then
                break
            elseif(mFindMultiColorNoTap(killMiser)) then
                mTracePrint("战斗中..")
                MaticNFC=0
            elseif(not mFindMultiColorNoTap(miserLogo2)) then
                break
            else
                MaticNFC=MaticNFC+3
                mMessageBoxEx("MaticNFC.."..MaticNFC,1000)
                mFindMultiColor(color_use)
                if(MaticNFC>=90) then
                    break
                end
            end
            Sleep(3000)
        end
        mTracePrint("---------------守财:战斗结束------------------------")
        Sleep(1000)
        mFindMultiColor(cancelAutoMaitc)
        Sleep(1000)
        mFindMultiColor(callFollow)
    end
end
--检查剧情副本
function checkJQFB()
    local joinJQ2={"参加剧情2:",818,90,1163,278,"52A2D6-101010","1|12|317DBD-101010,-165|-26|FFFFFF-101010,-180|-26|FFFFFF-101010,-199|-26|FFFFFF-101010,-205|-17|FFFFFF-101010,-232|-22|FFFFFF-101010,-244|-13|FFFBFF-101010,-258|-26|FFFFFF-101010,-256|-7|FFFFFF-101010"}
    local joinJQ={"参加剧情:",372,25,699,159,"529ED6-101010","-29|1|398AC6-101010,-199|-32|FFFFFF-101010,-188|-14|FFFFFF-101010,-272|-19|FFFFFF-101010,-276|-27|FFFFFF-101010,-263|-25|D6D7DE-101010,-250|-13|FFFFFF-101010,-230|-21|FFFFFF-101010"}
    if(mFindMultiColor(color_activity)) then
        mMessageBoxEx("活动面板",1000)
        Sleep(1000)
    else
        mFindMultiColor(color_window_close)
    end
    mFindMultiColor(dailyBar)
    Sleep(1000)
    if(mFindMultiColor_offset(dailyBarSelected,310,-70)) then
        mTracePrint("我要装备")
        Sleep(1000)
        if(mFindMultiColor(joinJQ)) then
            return 0
        elseif(mFindMultiColor(joinJQ2)) then
            return 0
        else
            mFindMultiColor(color_window_close)
        end
    end
    return -1
end
function JQFB()
    local heroModel={"英雄模式",996,128,1061,161,"ADFBFF-101010","10|3|ADFBFF-101010,19|18|ADF7FF-101010,33|15|ADF7FF-101010,42|6|ADFBFF-101010,42|17|ADFBFF-101010,36|4|ADFBFF-101010"}
    local normalModel={"普通模式",852,129,910,159,"ADF7FF-101010","10|2|ADFBFF-101010,7|7|ADF7FF-101010,2|7|ADFBFF-101010,-2|19|ADF7FF-101010,20|18|A5EFFF-101010,28|19|9CE7F7-101010,27|5|ADFBFF-101010,39|0|A5EBF7-101010"}
    local selecetLevel={"选择挑战等级",171,131,235,166,"ADFBFF-101010","8|4|9CDFE7-101010,8|14|ADFBFF-101010,5|18|ADFBFF-101010,18|14|ADFBFF-101010,29|6|A5EBF7-101010,43|8|ADF7FF-101010,43|20|ADFBFF-101010"}
    local challenge1={"重温1:",278,512,314,578,"FFFFFF-101010","-8|6|EFF3F7-101010,-10|12|428ECE-101010,9|15|FFFFFF-101010,12|16|3986C6-101010,8|32|FFFFFF-101010,-8|32|FFFBFF-101010,-8|41|FFFFFF-101010,11|44|F7F7FF-101010"}
    local challenge2={"重温2:",473,514,509,577,"63AADE-101010","-8|6|FFFFFF-101010,-9|18|FFFFFF-101010,-9|25|3986C6-101010,-1|36|DEE3E7-101010,-8|44|FFFBFF-101010,10|47|F7F7F7-101010,8|28|FFFFFF-101010,8|18|FFFFFF-101010"}
    local challenge3={"重温3:",668,513,703,577,"63AEE7-101010","0|6|FFFFFF-101010,-7|15|FFFFFF-101010,-10|16|428EC6-101010,1|22|C6CBD6-101010,-8|35|FFFBFF-101010,-5|47|F7FBFF-101010,-9|46|FFFFFF-101010,9|18|FFFFFF-101010"}
    local challenge4={"重温4:",861,514,897,578,"63AEDE-101010","0|4|FFFFFF-101010,-7|16|FFFFFF-101010,-7|23|C6CBD6-101010,2|26|398AC6-101010,-8|45|FFFFFF-101010,11|48|F7F7FF-101010,9|19|FFFFFF-101010,9|20|18385A-101010"}
    local challenge5={"重温5:",1056,514,1090,578,"63AADE-101010","0|6|FFFFFF-101010,-9|18|FFFFFF-101010,-10|25|3986C6-101010,-10|34|FFFFFF-101010,-4|47|F7F7FF-101010,10|47|F7F7F7-101010,8|29|FFFFFF-101010,6|33|29598C-101010"}
    local challengeTable={challenge1,challenge2,challenge3,challenge4,challenge5}
    local confrimInto={"确认进入",765,406,830,442,"F7AE42-101010","5|13|DE8618-101010,8|8|FFFFFF-101010,23|9|FFFFFF-101010,37|7|FFE7CE-101010,37|-3|FFFFFF-101010,21|-2|734521-101010,-1|-5|FFFBF7-101010"}
    local FbFlag={"宝图副本标志",1055,101,1112,160,"9CEF3A-101010","-8|-15|FFFF52-101010,-21|11|21CAFF-101010,-10|3|6BDB08-101010,-23|16|31C2EE-101010,-28|16|EEC610-101010,-7|23|FFFFFF-101010"}
    local level_one={"10-30级:",167,194,255,222,"FFFFFF-101010","0|6|FFFFFF-101010,0|11|FFFFFF-101010,0|14|FFFFFF-101010,3|14|FFFFFF-101010,12|14|EFFBFF-101010,12|-1|FFFFFF-101010"}
    local level_two={"35-55级:",165,222,254,246,"FFFFFF-101010","-13|-5|FFFFFF-101010,-7|-3|FFFFFF-101010,-16|-10|FFFFFF-101010,-14|5|FFFFFF-101010,-20|5|F7FBFF-101010,-4|-4|F7FBFF-101010"}
    local level_three={"60-80级",166,247,251,271,"F7FFFF-101010","2|9|EFFBFF-101010,5|10|FFFFFF-101010,8|6|FFFFFF-101010,7|-5|FFFFFF-101010,12|4|FFFFFF-101010,16|10|FFFFFF-101010"}
    local level_four={"85-105级",166,272,266,298,"FFFFFF-101010","2|11|FFFFFF-101010,5|4|FFFFFF-101010,7|-3|FFFFFF-101010,14|-4|FFFFFF-101010,13|2|FFFFFF-101010,14|11|FFFFFF-101010"}
    local level_five={"110-130级",167,297,249,325,"FFFFFF-101010","0|14|FFFFFF-101010,13|13|FFFFFF-101010,13|0|FFFFFF-101010,21|5|FFFFFF-101010,23|0|FFFFFF-101010,13|7|FFFFFF-101010"}
    local level_six={"135-150级",165,322,256,348,"FFFFFF-101010","0|14|FFFFFF-101010,9|14|FFFFFF-101010,13|15|FFFFFF-101010,12|7|FFFFFF-101010,16|11|FFFFFF-101010,15|5|FFFFFF-101010"}
    local levelTable={level_one,level_two,level_three,level_four,level_five,level_six}
    local selecetoffset={}
    --UI配置
    local levelIndex=-1
    local index=-1
    local JqfbModel=getSelectsCheckItemIndex("JQFB_MODEL")
    local JqfbLevel=getSelectsCheckItemIndex("JQFB_LEVEL")
    local IsJqfb=checkgetselected("CheckBoxJQFB")
    local IntoExceptionCount=0
    if(IsJqfb) then
        mTracePrint("开始剧情副本")
    else
        return
    end
    --切到队伍界面
    while(not mFindMultiColor(callFollow)) do
        mTracePrint("切到队伍信息")
        if(mFindMultiColor_offset(color_taskbar_on,100,0))then
            Sleep(1000) 
        else
            mFindMultiColor(color_window_close)
        end
    end
    ---确认接取成功
    while(true) do
        local ret=checkJQFB()
        if(ret==0) then
            mTracePrint("接取剧情成功")
            Sleep(1000)
            break
        elseif(ret==-1) then
            mTracePrint("接取剧情失败")
        elseif(ret==1) then
            mTracePrint("剧情已完成")
            return
        end
    end
    --切换模式
    while(true) do
        if(JqfbModel==0) then
            if(mFindMultiColor(normalModel) or mFindMultiColorNoTap(heroModel)) then
                mTracePrint("普通模式")
                break
            end
        elseif(JqfbModel==1) then
            if(mFindMultiColor(heroModel) or mFindMultiColorNoTap(normalModel)) then
                mTracePrint("英雄模式")
                break
            end
        else
            Sleep(2000)
        end
    end
    --初始数据
    JqfbLevel=JqfbLevel+1
    if(math.fmod(JqfbLevel,5)==0 and JqfbLevel ~= 0) then
        index=5
    else
        index=math.fmod(JqfbLevel,5)
    end
    if(JqfbLevel >= 1 and JqfbLevel <= 5) then
        levelIndex=1
    elseif(JqfbLevel >= 6 and JqfbLevel <= 10) then
        levelIndex=2
    elseif(JqfbLevel >= 11 and JqfbLevel <= 15) then
        levelIndex=3
    elseif(JqfbLevel >= 16 and JqfbLevel <= 20) then
        levelIndex=4
    elseif(JqfbLevel >= 21 and JqfbLevel <= 25) then
        levelIndex=5
    elseif(JqfbLevel >= 26 and JqfbLevel <= 30) then
        levelIndex=6
    end
    mTracePrint("levelIndex:"..levelIndex.." index:"..index)
    --选择剧情等级
    if(mFindMultiColor(selecetLevel)) then
        Sleep(1000)
        if(mFindMultiColor(levelTable[levelIndex]))then
            mTracePrint("DEBUG:选择副本等级")
            while(not mFindMultiColorNoTap(FbFlag)) do
                if(mFindMultiColor(challengeTable[index]))then
                    Sleep(1000)
                else
                    IntoExceptionCount=IntoExceptionCount+2
                    if(IntoExceptionCount>=40) then
                        mMessageBoxEx("进本异常.."..IntoExceptionCount,2000)
                    end
                    Sleep(2000)
                end
            end
        else
            mFindMultiColor(selecetLevel)
        end
    end
    --单人模式出现
    if(mFindMultiColor(confrimInto)) then
        mTracePrint("进入剧情副本")
    end
    --进入副本后 前移一段
    if(mFindMultiColorNoTap(FbFlag)) then
        mMessageBoxEx("前移一段",2000)
        IntoExceptionCount=0
        mTouch(165,322,256,348,3000,0)
    end
    local CancleFollowFlag=true
    while(mFindMultiColorNoTap(FbFlag)) do
        mTracePrint("副本中...")
        mFindMultiColor(automatic)
        if(CancleFollowFlag) then
            if(mFindMultiColor(cancelFoloow)) then
                CancleFollowFlag=false
            end
        end
        if(mFindMultiColor(color_revive)) then
            mTracePrint("死亡退出副本..")
            mMessageBoxEx("死亡退出副本..",2000)
            Sleep(2000)
            break
        end
        Sleep(3000)
    end
    mTracePrint("--------------退出副本-----------------")
end
function cs()
    local intoCaiWei={"进入采薇副本",1088,467,1150,499,"FFFFFF-101010","-7|-5|FFFBFF-101010,-4|9|317DC6-101010,7|0|FFFFFF-101010,4|-7|6BB2E7-101010,8|-7|FFFFFF-101010,20|-10|EFF7FF-101010,16|7|3986C6-101010,28|7|FFFFFF-101010"}
    local offlineExp={"离线经验",611,400,669,433,"428ECE-101010","4|-4|FFFFFF-101010,7|-14|FFFBFF-101010,16|-10|7BBEEF-101010,16|-5|EFF7FF-101010,20|2|3175B5-101010,27|2|3986C6-101010,32|-8|FFFFFF-101010,38|4|FFFFFF-101010"}
    local color_deny={"拒绝队长申请 and 拒绝关宁..",479,399,517,445,"FFFFFF-222222","-9|17|6B9AC6-222222,-6|9|E7EFFF-222222,-1|17|B5C7DE-222222,10|17|426D94-222222,-1|-14|94E3FF-222222"}
    while(true) do
        if(mFindMultiColorNoTap(challenge1)) then
            traceprint("success")
        else
            traceprint("failed")
        end
        mTouch(199,578,199,462,4000,0)
        countDown("啊哈哈",3)
    end
end