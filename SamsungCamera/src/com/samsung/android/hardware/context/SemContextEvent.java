package com.samsung.android.hardware.context;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class SemContextEvent implements Parcelable {
    static final Creator<SemContextEvent> CREATOR = new Creator<SemContextEvent>() {
        public SemContextEvent createFromParcel(Parcel in) {
            return new SemContextEvent(in);
        }

        public SemContextEvent[] newArray(int size) {
            return new SemContextEvent[size];
        }
    };
    public Bundle context;
    //private SemContextEventContext mEventContext;
    //public SemContext semContext;
    public long timestamp;

    public SemContextEvent() {
        //this.semContext = new SemContext();
        this.timestamp = 0;
    }

    public SemContextEvent(Parcel src) {
        readFromParcel(src);
    }

    /*
    public SemContextApproach getApproachContext() {
        return (SemContextApproach) this.mEventContext;
    }

    public SemContextPedometer getPedometerContext() {
        return (SemContextPedometer) this.mEventContext;
    }

    SemContextStepCountAlert getStepCountAlertContext() {
        return (SemContextStepCountAlert) this.mEventContext;
    }

    public SemContextMovement getMovementContext() {
        return (SemContextMovement) this.mEventContext;
    }

    public SemContextAutoRotation getAutoRotationContext() {
        return (SemContextAutoRotation) this.mEventContext;
    }

    public SemContextAirMotion getAirMotionContext() {
        return (SemContextAirMotion) this.mEventContext;
    }

    public SemContextCallPose getCallPoseContext() {
        return (SemContextCallPose) this.mEventContext;
    }

    public SemContextShakeMotion getShakeMotionContext() {
        return (SemContextShakeMotion) this.mEventContext;
    }

    public SemContextFlipCoverAction getFlipCoverActionContext() {
        return (SemContextFlipCoverAction) this.mEventContext;
    }

    public SemContextGyroTemperature getGyroTemperatureContext() {
        return (SemContextGyroTemperature) this.mEventContext;
    }

    public SemContextPutDownMotion getPutDownMotionContext() {
        return (SemContextPutDownMotion) this.mEventContext;
    }

    public SemContextWakeUpVoice getWakeUpVoiceContext() {
        return (SemContextWakeUpVoice) this.mEventContext;
    }

    public SemContextBounceShortMotion getBounceShortMotionContext() {
        return (SemContextBounceShortMotion) this.mEventContext;
    }

    public SemContextBounceLongMotion getBounceLongMotionContext() {
        return (SemContextBounceLongMotion) this.mEventContext;
    }

    @Deprecated
    public SemContextWristUpMotion getWristUpMotionContext() {
        return (SemContextWristUpMotion) this.mEventContext;
    }

    public SemContextFlatMotion getFlatMotionContext() {
        return (SemContextFlatMotion) this.mEventContext;
    }

    @Deprecated
    public SemContextMovementAlert getMovementAlertContext() {
        return (SemContextMovementAlert) this.mEventContext;
    }

    public SemContextDevicePosition getDevicePositionContext() {
        return (SemContextDevicePosition) this.mEventContext;
    }

    public SemContextActivityLocationLogging getActivityLocationLoggingContext() {
        return (SemContextActivityLocationLogging) this.mEventContext;
    }

    public SemContextActivityTracker getActivityTrackerContext() {
        return (SemContextActivityTracker) this.mEventContext;
    }

    public SemContextActivityBatch getActivityBatchContext() {
        return (SemContextActivityBatch) this.mEventContext;
    }

    public SemContextActivityNotification getActivityNotificationContext() {
        return (SemContextActivityNotification) this.mEventContext;
    }

    public SemContextSpecificPoseAlert getSpecificPoseAlertContext() {
        return (SemContextSpecificPoseAlert) this.mEventContext;
    }

    public SemContextActivityNotificationEx getActivityNotificationExContext() {
        return (SemContextActivityNotificationEx) this.mEventContext;
    }

    public SemContextActivityNotificationForLocation getActivityNotificationForLocationContext() {
        return (SemContextActivityNotificationForLocation) this.mEventContext;
    }

    SemContextCallMotion getCallMotionContext() {
        return (SemContextCallMotion) this.mEventContext;
    }

    public SemContextStepLevelMonitor getStepLevelMonitorContext() {
        return (SemContextStepLevelMonitor) this.mEventContext;
    }

    public SemContextActiveTimeMonitor getActiveTimeMonitorContext() {
        return (SemContextActiveTimeMonitor) this.mEventContext;
    }

    public SemContextSedentaryTimer getSedentaryTimerContext() {
        return (SemContextSedentaryTimer) this.mEventContext;
    }

    public SemContextFlatMotionForTableMode getFlatMotionForTableModeContext() {
        return (SemContextFlatMotionForTableMode) this.mEventContext;
    }

    public SemContextAutoBrightness getAutoBrightnessContext() {
        return (SemContextAutoBrightness) this.mEventContext;
    }

    public SemContextAbnormalPressure getAbnormalPressureContext() {
        return (SemContextAbnormalPressure) this.mEventContext;
    }

    public SemContextPhoneStatusMonitor getPhoneStatusMonitorContext() {
        return (SemContextPhoneStatusMonitor) this.mEventContext;
    }

    public SemContextHallSensor getHallSensorContext() {
        return (SemContextHallSensor) this.mEventContext;
    }

    public SemContextEnvironmentAdaptiveDisplay getEnvironmentAdaptiveDisplayContext() {
        return (SemContextEnvironmentAdaptiveDisplay) this.mEventContext;
    }

    public SemContextWirelessChargingDetection getWirelessChargingDetectionContext() {
        return (SemContextWirelessChargingDetection) this.mEventContext;
    }

    public SemContextLocationCore getLocationCoreContext() {
        return (SemContextLocationCore) this.mEventContext;
    }

    @Deprecated
    public SemContextFlipMotion getFlipMotionContext() {
        return (SemContextFlipMotion) this.mEventContext;
    }

    public SemContextAnyMotionDetector getAnyMotionDetectorContext() {
        return (SemContextAnyMotionDetector) this.mEventContext;
    }

    public SemContextCarryingDetection getCarryingDetectionContext() {
        return (SemContextCarryingDetection) this.mEventContext;
    }

    public SemContextSensorStatusCheck getSensorStatusCheckContext() {
        return (SemContextSensorStatusCheck) this.mEventContext;
    }

    public SemContextLocationChangeTrigger getLocationChangeTriggerContext() {
        return (SemContextLocationChangeTrigger) this.mEventContext;
    }

    public SemContextFreeFallDetection getFreeFallDetectionContext() {
        return (SemContextFreeFallDetection) this.mEventContext;
    }

    public void setContextEvent(int event, Bundle context) {
        this.semContext.setType(event);
        this.timestamp = System.nanoTime();
        this.context = context;
        switch (event) {
            case 1:
                this.mEventContext = new SemContextApproach();
                this.mEventContext.setValues(context);
                return;
            case 2:
                this.mEventContext = new SemContextPedometer();
                this.mEventContext.setValues(context);
                return;
            case 3:
                this.mEventContext = new SemContextStepCountAlert();
                this.mEventContext.setValues(context);
                return;
            case 5:
                this.mEventContext = new SemContextMovement();
                this.mEventContext.setValues(context);
                return;
            case 6:
                this.mEventContext = new SemContextAutoRotation();
                this.mEventContext.setValues(context);
                return;
            case 7:
                this.mEventContext = new SemContextAirMotion();
                this.mEventContext.setValues(context);
                return;
            case 11:
                this.mEventContext = new SemContextCallPose();
                this.mEventContext.setValues(context);
                return;
            case 12:
                this.mEventContext = new SemContextShakeMotion();
                this.mEventContext.setValues(context);
                return;
            case 13:
                this.mEventContext = new SemContextFlipCoverAction();
                this.mEventContext.setValues(context);
                return;
            case 14:
                this.mEventContext = new SemContextGyroTemperature();
                this.mEventContext.setValues(context);
                return;
            case 15:
                this.mEventContext = new SemContextPutDownMotion();
                this.mEventContext.setValues(context);
                return;
            case 16:
                this.mEventContext = new SemContextWakeUpVoice();
                this.mEventContext.setValues(context);
                return;
            case 17:
                this.mEventContext = new SemContextBounceShortMotion();
                this.mEventContext.setValues(context);
                return;
            case 18:
                this.mEventContext = new SemContextBounceLongMotion();
                this.mEventContext.setValues(context);
                return;
            case 19:
                this.mEventContext = new SemContextWristUpMotion();
                this.mEventContext.setValues(context);
                return;
            case 20:
                this.mEventContext = new SemContextFlatMotion();
                this.mEventContext.setValues(context);
                return;
            case 21:
                this.mEventContext = new SemContextMovementAlert();
                this.mEventContext.setValues(context);
                return;
            case 22:
                this.mEventContext = new SemContextDevicePosition();
                this.mEventContext.setValues(context);
                return;
            case 24:
                this.mEventContext = new SemContextActivityLocationLogging();
                this.mEventContext.setValues(context);
                return;
            case 25:
                this.mEventContext = new SemContextActivityTracker();
                this.mEventContext.setValues(context);
                return;
            case 26:
                this.mEventContext = new SemContextActivityBatch();
                this.mEventContext.setValues(context);
                return;
            case 27:
                this.mEventContext = new SemContextActivityNotification();
                this.mEventContext.setValues(context);
                return;
            case 28:
                this.mEventContext = new SemContextSpecificPoseAlert();
                this.mEventContext.setValues(context);
                return;
            case 30:
                this.mEventContext = new SemContextActivityNotificationForLocation();
                this.mEventContext.setValues(context);
                return;
            case 32:
                this.mEventContext = new SemContextCallMotion();
                this.mEventContext.setValues(context);
                return;
            case 33:
                this.mEventContext = new SemContextStepLevelMonitor();
                this.mEventContext.setValues(context);
                return;
            case 34:
                this.mEventContext = new SemContextActiveTimeMonitor();
                this.mEventContext.setValues(context);
                return;
            case 35:
                this.mEventContext = new SemContextSedentaryTimer();
                this.mEventContext.setValues(context);
                return;
            case 36:
                this.mEventContext = new SemContextFlatMotionForTableMode();
                this.mEventContext.setValues(context);
                return;
            case 39:
                this.mEventContext = new SemContextAutoBrightness();
                this.mEventContext.setValues(context);
                return;
            case 41:
                this.mEventContext = new SemContextAbnormalPressure();
                this.mEventContext.setValues(context);
                return;
            case 42:
                this.mEventContext = new SemContextPhoneStatusMonitor();
                this.mEventContext.setValues(context);
                return;
            case 43:
                this.mEventContext = new SemContextHallSensor();
                this.mEventContext.setValues(context);
                return;
            case 44:
                this.mEventContext = new SemContextEnvironmentAdaptiveDisplay();
                this.mEventContext.setValues(context);
                return;
            case 46:
                this.mEventContext = new SemContextWirelessChargingDetection();
                this.mEventContext.setValues(context);
                return;
            case 47:
                this.mEventContext = new SemContextLocationCore();
                this.mEventContext.setValues(context);
                return;
            case 49:
                this.mEventContext = new SemContextFlipMotion();
                this.mEventContext.setValues(context);
                return;
            case 50:
                this.mEventContext = new SemContextAnyMotionDetector();
                this.mEventContext.setValues(context);
                return;
            case 51:
                this.mEventContext = new SemContextCarryingDetection();
                this.mEventContext.setValues(context);
                return;
            case 52:
                this.mEventContext = new SemContextSensorStatusCheck();
                this.mEventContext.setValues(context);
                return;
            case 54:
                this.mEventContext = new SemContextLocationChangeTrigger();
                this.mEventContext.setValues(context);
                return;
            case 55:
                this.mEventContext = new SemContextFreeFallDetection();
                this.mEventContext.setValues(context);
                return;
            default:
                return;
        }
    }
    */

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
	    /*
        dest.writeLong(this.timestamp);
        dest.writeParcelable(this.semContext, flags);
        dest.writeParcelable(this.mEventContext, flags);
        dest.writeBundle(this.context);
	*/
    }

    private void readFromParcel(Parcel src) {
	    /*
        this.timestamp = src.readLong();
        this.semContext = (SemContext) src.readParcelable(SemContext.class.getClassLoader());
        this.mEventContext = (SemContextEventContext) src.readParcelable(SemContextEventContext.class.getClassLoader());
        this.context = src.readBundle(getClass().getClassLoader());
	*/
    }
}
