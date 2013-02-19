package common
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;

   public class UserPanel extends McUserPanel
   {
      private var _userNameTextField:TextField;
      private var _photoHolder:MovieClip;
      private var _userImage:DisplayObject;
      
      public function UserPanel()
      {
         super();
         _userNameTextField = this.mcUserName["tfName"] as TextField;
         _photoHolder = this.mcPhotoMask["mcPhotoHolder"] as MovieClip;
      }
      
      public function get userName():String
      {
         return _userNameTextField.text;
      }
      
      public function set userName(value:String):void
      {
         _userNameTextField.text = value;
      }
      
      public function get userImage():DisplayObject
      {
         return _userImage;
      }
      
      public function set userImage(value:DisplayObject):void
      {
         _userImage = value;
         _userImage.width = _photoHolder.width;
         _userImage.height = _photoHolder.height;
         _photoHolder.removeChildAt(1);
         _photoHolder.addChildAt(_userImage, 1);
      }
   }
}