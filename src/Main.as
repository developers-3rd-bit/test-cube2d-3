package
{
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import com.halcyon.layout.common.HalcyonCanvas;
   import com.halcyon.layout.common.HalcyonHGroup;
   import com.halcyon.layout.common.HalcyonVGroup;
   import com.halcyon.layout.common.LayoutEvent;
   
   import fl.controls.Button;
   
   import flash.display.Sprite;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [SWF(width="1200", height="700")]
   public class Main extends Sprite
   {
      public static const APP_HEIGHT:Number = 700;
      public static const APP_WIDTH:Number = 1200;
      
      private var _canvas:HalcyonCanvas;
      private var _bg:McBg;
      private var _vGroup:HalcyonVGroup;
      private var _hGroup1:HalcyonHGroup;
      private var _hGroup2:HalcyonHGroup;
      private var _hGroup3:HalcyonHGroup;
      private var _addButton:Button;
      private var _deleteButton:Button;
      private var HGROUP_HEIGHT:int = 210;
      
      public function Main()
      {
         _canvas = new HalcyonCanvas(this, APP_WIDTH, APP_HEIGHT);
         this.addChild(_canvas);
         
         _bg = new McBg();
         _canvas.prepareElementAndPosition(_bg, 0, 0, 0, 0);
         
         _addButton = new Button();
         _addButton.useHandCursor = true;
         _addButton.label = "Add";
         _addButton.addEventListener(MouseEvent.CLICK, onAddButtonClick, false, 0, true);
         _canvas.prepareElementAndPosition(_addButton, 5, NaN, 5, NaN);
         
         _deleteButton = new Button();
         _deleteButton.useHandCursor = true;
         _deleteButton.label = "Delete";
         _deleteButton.addEventListener(MouseEvent.CLICK, onDeleteButtonClick, false, 0, true);
         _canvas.prepareElementAndPosition(_deleteButton, 5, NaN, _addButton.width + 10, NaN);
         
         _vGroup = new HalcyonVGroup(_canvas);
         _vGroup.paddingLeft = 105;
         _vGroup.verticalGap = 7;
         _canvas.prepareElementAndPosition(_vGroup, 40, 10, 5, 5);
         
         _hGroup1 = new HalcyonHGroup(_vGroup, _vGroup.width, HGROUP_HEIGHT);
         _hGroup1.horizontalgap = 30;
         _vGroup.addChild(_hGroup1);
         
         _hGroup2 = new HalcyonHGroup(_vGroup, _vGroup.width, HGROUP_HEIGHT);
         _hGroup2.horizontalgap = 30;
         _vGroup.addChild(_hGroup2);
         
         _hGroup3 = new HalcyonHGroup(_vGroup, _vGroup.width, HGROUP_HEIGHT);
         _hGroup3.horizontalgap = 30;
         _vGroup.addChild(_hGroup3);
         
         stage.scaleMode = StageScaleMode.NO_SCALE;
      }
      
      private function onAddButtonClick(event:Event):void
      {
         resetSpotLight();
         var hGroup:HalcyonHGroup;
         if(_hGroup1.numChildren < 4) hGroup = _hGroup1;
         else if(_hGroup2.numChildren < 4) hGroup = _hGroup2;
         else if(_hGroup3.numChildren < 4) hGroup = _hGroup3;
         if(hGroup == null) return;
         var view:View = new View(hGroup, 220, HGROUP_HEIGHT);
         var totalChildren:Number = _hGroup1.numChildren + _hGroup2.numChildren + _hGroup3.numChildren;
         view.userName = "User " + totalChildren;
         view.addEventListener(View.CUBE_CLICK, onCubeClick, false, 0, true);
         hGroup.addChild(view);
      }
      
      private var _viewInSpotLight:View;
      private var _viewInSpotLightIndex:Number;
      private var _viewInSpotLightX:Number;
      private var _viewInSpotLightY:Number;
      private var _viewInSpotLightParent:HalcyonHGroup;
      
      private function onCubeClick(layoutEvent:LayoutEvent):void
      {
         var eventSource:View;
         var eventSourceName:String;
         if(layoutEvent != null) 
         {
            eventSource = layoutEvent.extra as View;
            eventSourceName = eventSource.name;
            eventSource.inSpotLight ? eventSource.unScale() : eventSource.scale();
            if(layoutEvent.extra == _viewInSpotLight)
            {
               tweenedReset();
               return;
            }
         }
         resetSpotLight();
         for(var i:int=0;i<_vGroup.numChildren;i++)
         {
            var hGroup:HalcyonHGroup = _vGroup.getChildAt(i) as HalcyonHGroup;
            if(hGroup == null) continue;
            for(var j:int=0;j<hGroup.numChildren;j++)
            {
               var view:View = hGroup.getChildAt(j) as View;
               if(view == null) continue;
               if(view.name == eventSourceName)
               {
                  var xValue:Number = (APP_WIDTH - view.width) / 2;
                  var yValue:Number = (APP_HEIGHT - view.height) / 2;
                  _viewInSpotLightIndex = hGroup.getChildIndex(view);
                  this.addChild(view);
                  _viewInSpotLightX = view.x;
                  _viewInSpotLightY = view.y;
                  TweenMax.to(view, .5, {x:xValue, y:yValue});
                  _viewInSpotLight = view;
                  _viewInSpotLightParent = hGroup;
                  break;
               }
            }
         }
      }
      
      private function tweenedReset():void
      {
         var tweenMax:TweenMax = TweenMax.to(_viewInSpotLight, .5, {x:_viewInSpotLightX, y:_viewInSpotLightY});
         tweenMax.addEventListener(TweenEvent.COMPLETE, resetSpotLight, false, 0, true);
      }
      
      private function resetSpotLight(event:Event = null):void
      {
         if(event != null)
            (event.currentTarget as TweenMax).removeEventListener(TweenEvent.COMPLETE, resetSpotLight);
         if(_viewInSpotLight == null) return;
         _viewInSpotLight.unScale();
         this.removeChild(_viewInSpotLight);
         _viewInSpotLightParent.addChildAt(_viewInSpotLight, _viewInSpotLightIndex);
         _viewInSpotLightParent.refresh();
         _viewInSpotLight = null;
         _viewInSpotLightX = NaN;
         _viewInSpotLightY = NaN;
         _viewInSpotLightIndex = NaN;
         _viewInSpotLightParent = null;
      }
      
      private function onDeleteButtonClick(event:Event):void
      {
         resetSpotLight();
         var hGroup:HalcyonHGroup;
         if(_hGroup3.numChildren > 0) hGroup = _hGroup3;
         else if(_hGroup2.numChildren > 0) hGroup = _hGroup2;
         else if(_hGroup1.numChildren > 0) hGroup = _hGroup1;
         if(hGroup == null) return;
         var view:View = hGroup.getChildAt(hGroup.numChildren - 1) as View;
         if(view == null) return;
         view.removeEventListener(View.CUBE_CLICK, onCubeClick);
         hGroup.removeChildAt(hGroup.numChildren - 1);
         view = null;
      }
   }
}