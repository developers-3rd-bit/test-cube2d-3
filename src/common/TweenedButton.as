package common
{
   import com.greensock.TweenMax;
   
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;

   public class TweenedButton extends Sprite
   {
      private var _tween:TweenMax;
      private var _icon:Sprite;
      private var _enabled:Boolean = true;
      
      public function TweenedButton(argClass:Class, argWidth:Number = 12, argHeight:Number = 12)
      {
         this.buttonMode = true;
         _icon = new argClass();
         _icon.width = argWidth;
         _icon.height = argHeight;
         this.addChild(_icon);
         this.width = argWidth;
         this.height = argHeight;
         this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
         this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
      }
      
      public function get icon():Sprite
      {
         return _icon;
      }
      
      public function get enabled():Boolean
      {
         return _enabled;
      }
      
      public function set enabled(value:Boolean):void 
      {
         if(value) 
         {
            this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
            this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
         } 
         else 
         {
            this.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
            this.removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
         }
         onMouseOut(null);
         this.buttonMode = value;
         this._enabled = value;
      }
      
      private function onMouseOver(event:Event):void 
      {
         _tween = TweenMax.to(this, .2, {colorMatrixFilter:{colorize:0x0000ff, amount:.5}});
      }
      
      private function onMouseOut(event:Event):void 
      {
         if(_tween) 
            _tween.reverse();
      }
   }
}