package
{
   import com.greensock.TweenMax;
   import com.halcyon.layout.common.HalcyonCanvas;
   import com.halcyon.layout.common.HalcyonVGroup;
   import com.halcyon.layout.common.LayoutEvent;
   
   import common.TweenedButton;
   import common.UserPanel;
   
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class View extends HalcyonCanvas
   {
      public static const WEBCAM_BTN_CLICK:String = "webcamBtnClick";
      public static const CALL_BTN_CLICK:String = "callBtnClick";
      public static const INFO_BTN_CLICK:String = "infoBtnClick";
      public static const HELP_BTN_CLICK:String = "helpBtnClick";
      public static const AWAY_BTN_CLICK:String = "awayBtnClick";
      public static const CUBE_CLICK:String = "cubeClick";
      
      private var _userPanel:UserPanel;
      private var _buttonsVGroup:HalcyonVGroup;
      private var _webcamBtn:TweenedButton;
      private var _callBtn:TweenedButton;
      private var _infoBtn:TweenedButton;
      private var _helpBtn:TweenedButton;
      private var _awayBtn:TweenedButton;
      private var _buttonWidthHeight:Number;
      private var HORIZONTAL_GAP:int = 7;
      private var VERTICAL_GAP:int;
      private var TOTAL_BUTTONS:int = 5;
      
      private var _inSpotLight:Boolean = false;
      
      public function View(reference:DisplayObjectContainer, width:Number, height:Number)
      {
         super(reference, width, height);
         
         VERTICAL_GAP = height / TOTAL_BUTTONS / 3;
         _buttonWidthHeight = (height - (VERTICAL_GAP * 4)) / 5;
         
         _userPanel = new UserPanel();
         _userPanel.addEventListener(MouseEvent.CLICK, onCubeClick, false, 0, true);
         this.prepareElementAndPosition(_userPanel, 37, 15, 0, _buttonWidthHeight + HORIZONTAL_GAP);
         
         _buttonsVGroup = new HalcyonVGroup(this, _buttonWidthHeight, height);
         _buttonsVGroup.paddingTop = 10;
         _buttonsVGroup.verticalGap = VERTICAL_GAP;
         
         _webcamBtn = new TweenedButton(McWebcam, _buttonWidthHeight, _buttonWidthHeight);
         _webcamBtn.addEventListener(MouseEvent.CLICK, onWebcamBtnClick, false, 0, true);
         _buttonsVGroup.addChild(_webcamBtn);
         
         _callBtn = new TweenedButton(McCall, _buttonWidthHeight, _buttonWidthHeight);
         _callBtn.addEventListener(MouseEvent.CLICK, onCallBtnClick, false, 0, true);
         _buttonsVGroup.addChild(_callBtn);
         
         _infoBtn = new TweenedButton(McInfo, _buttonWidthHeight, _buttonWidthHeight);
         _infoBtn.addEventListener(MouseEvent.CLICK, onInfoBtnClick, false, 0, true);
         _buttonsVGroup.addChild(_infoBtn);
         
         _helpBtn = new TweenedButton(McHelp, _buttonWidthHeight, _buttonWidthHeight);
         _helpBtn.addEventListener(MouseEvent.CLICK, onHelpBtnClick, false, 0, true);
         _buttonsVGroup.addChild(_helpBtn);
         
         _awayBtn = new TweenedButton(McAway, _buttonWidthHeight, _buttonWidthHeight);
         _awayBtn.addEventListener(MouseEvent.CLICK, onAwayBtnClick, false, 0, true);
         _buttonsVGroup.addChild(_awayBtn);
         
         this.prepareElementAndPosition(_buttonsVGroup, 0, 0, _userPanel.width + HORIZONTAL_GAP, NaN);
         
         _buttonsVGroup.alpha = 0;
         
         this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
         this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
      }
      
      private function onMouseOver(event:Event):void
      {
         TweenMax.to(_buttonsVGroup, .5, {alpha:1});
      }
      
      private function onMouseOut(event:Event):void
      {
         TweenMax.to(_buttonsVGroup, .5, {alpha:0});
      }
      
      public function get inSpotLight():Boolean
      {
         return _inSpotLight;
      }
      
      private function onCubeClick(event:Event):void
      {
         var layoutEvent:LayoutEvent = new LayoutEvent(CUBE_CLICK);
         layoutEvent.extra = this;
         dispatchEvent(layoutEvent);
      }
      
      public function scale():void
      {
         this.scaleX = 1.5;
         this.scaleY = 1.5;
         _inSpotLight = true;
      }
      
      public function unScale():void
      {
         this.scaleX = 1;
         this.scaleY = 1;
         _inSpotLight = false;
      }
      
      public function set userName(value:String):void
      {
         _userPanel.userName = value;
      }
      
      public function set userImage(value:DisplayObject):void
      {
         _userPanel.userImage = value;
      }
      
      private function onWebcamBtnClick(event:Event):void
      {
         dispatchEvent(new Event(WEBCAM_BTN_CLICK));
      }
      
      private function onCallBtnClick(event:Event):void 
      {
         dispatchEvent(new Event(CALL_BTN_CLICK));
      }
      
      private function onInfoBtnClick(event:Event):void 
      {
         dispatchEvent(new Event(INFO_BTN_CLICK));
      }
      
      private function onHelpBtnClick(event:Event):void
      {
         dispatchEvent(new Event(HELP_BTN_CLICK));
      }
      
      private function onAwayBtnClick(event:Event):void 
      {
         dispatchEvent(new Event(AWAY_BTN_CLICK));
      }
   }
}