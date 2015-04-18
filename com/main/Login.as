package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	import com.stringutil.StringUtils;
	
	

	public class Login extends MovieClip {

		public var loginObj:loginWin;
		public var loaderCls:PreLoadAssets;
		
		public function Login() {
			
			loaderCls = new PreLoadAssets();
			addChild(loaderCls);
			
			loaderCls.pleaseWait("Loading User Login Window...");
			
			

			loginObj = new loginWin();
			addChild(loginObj);
			loginObj.x=600;
			loginObj.y=440;
			
			
			init();
			loginObj.loginBt.addEventListener(MouseEvent.CLICK, loginBtClick);
			
			
		}
		

		private function init():void {
			loaderCls.endWait();
			loginObj.msg_txt.visible=false;
			loginObj.msg_txt.defaultTextFormat=MainTextFormat.setLoginError();
		}


		public function loginBtClick(e:MouseEvent):void {
			if (emptyLogin()) {
				checkUserLogin(StringUtils.trim(loginObj.uname_txt.text) , StringUtils.trim(loginObj.password_txt.text));
			} else {
				loginObj.msg_txt.visible=true;
				loginObj.uname_txt.text = "";
				loginObj.password_txt.text = "";
				loginObj.msg_txt.text="Please fill username/password fields";
			}
		}
		

		function emptyLogin():Boolean {
			if (loginObj.uname_txt.length>0&&loginObj.password_txt.length>0) {
				return true;
			}
			return false;
		}
		
		//remoting
		private function checkUserLogin(uname:String , pass:String) {
			var _service = new NetConnection();
			_service.connect(Main.gateWay);
			var responder=new Responder(check_login_result,onFault);
			_service.call("AddOnCars.isUserExist", responder , uname , pass);
		}
		public function check_login_result(rs:Object) {
			if (rs) {
				loginObj.msg_txt.visible=false;
				loginObj.msg_txt.text='';
				MovieClip(parent).buildBackground();
				MovieClip(parent).buildBreadCrumb();
				MovieClip(parent).buildDashboard();
				MovieClip(parent).destroyLoginWindow();
			} else {
				loginObj.msg_txt.visible=true;
				loginObj.msg_txt.text="Invalid User/Password , try again";
			}
		}


		public function onFault(f:Event ) {
			trace("There was a problem");
		}



	}//$class
}//$package