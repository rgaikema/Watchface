import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.System as Sys;
using Toybox.Time.Gregorian as Date;
using Toybox.ActivityMonitor as Mon;

class WatchFace1View extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

        setStepCountDisplay();
        setClockDisplay();
        setDateDisplay();
        setFloorCountDisplay(); 

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        showBatteryIcon(dc);
        showStepsIcon(dc);
        showStairsIcon(dc);
        showCalendarIcon(dc);

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    private function setStepCountDisplay() {
    	var stepCount = Mon.getInfo().steps.toString();		
        var stepCountDisplay = View.findDrawableById("StepCountDisplay");      
        stepCountDisplay.setText(stepCount);		
    }

    private function setFloorCountDisplay() {
    	var floorCount = Mon.getInfo().floorsClimbed.toString();		
        var floorCountDisplay = View.findDrawableById("FloorCountDisplay");      
        floorCountDisplay.setText(floorCount);		
    }

    private function setClockDisplay() {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Update the view
        var view = View.findDrawableById("TimeDisplay") as Text;
        //.setColor(getApp().getProperty("ForegroundColor") as Number);
        view.setText(timeString);
    }

    private function setDateDisplay() {        
    	var now = Time.now();
        var date = Date.info(now, Time.FORMAT_LONG);
        //var dateString = Lang.format("$1$ $2$", [date.month, date.day]);
        var dateString = Lang.format("$1$", [date.day]);
        var monthString = Lang.format("$1$", [date.month]);
        var dateDisplay = View.findDrawableById("DateDisplay");
        var monthDisplay = View.findDrawableById("MonthDisplay");      
        dateDisplay.setText(dateString);
        monthDisplay.setText(monthString);	    	
    }

    function showCalendarIcon(dc) {
        //Calendar
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawRoundedRectangle(
            163,
            6, 
            34, 
            30, 
            3
        );
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.fillRoundedRectangle(
            163,
            6, 
            34, 
            6, 
            2
        );
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawRoundedRectangle(
            168,
            2, 
            6, 
            6, 
            2
        );
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawRoundedRectangle(
            186,
            2, 
            6, 
            6, 
            2
        );
    }

    function showStairsIcon(dc) {
        //Stair V1
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawLine(
            2, 
            186, 
            1, 
            176
        );
        //Stair H1
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawLine(
            1, 
            176, 
            11, 
            176
        );
        //Stair V2
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawLine(
            11, 
            176, 
            10, 
            166
        );
        //Stair H2
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawLine(
            10, 
            166, 
            20, 
            166
        );
        //Stair V3
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawLine(
            20, 
            166, 
            19, 
            156
        );
    }


    function showStepsIcon(dc) {
        //Steps
        //Elipse 1
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.fillEllipse(
            330,
            174,
            6,
            10
        );
        // Circle 1
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.fillCircle(
            330, 
            184, 
            4
        );


        //Elipse 2
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.fillEllipse(
            344,
            160,
            6,
            10
        );
        // Circle 2
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.fillCircle(
            344, 
            170, 
            4
        );
    }

    function showBatteryIcon(dc) {
        var battery = Sys.getSystemStats().battery;
        var batteryDisplay = View.findDrawableById("BatteryDisplay");      
	    batteryDisplay.setText(battery.format("%d")+"%");	

        var newWidth = battery / 100 * 28;
        var roundedWidth = newWidth.toNumber();	

	    


	    //Battery
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawRoundedRectangle(
            162,
            334, 
            34, 
            18, 
            3
        );
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.fillRoundedRectangle(
            164,
            336, 
            roundedWidth, 
            14, 
            3
        );
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawRoundedRectangle(
            196,
            338, 
            3, 
            10, 
            3
        );
    }
}
