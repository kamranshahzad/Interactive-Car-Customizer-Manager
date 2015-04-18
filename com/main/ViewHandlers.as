package com.main{


	import flash.display.SimpleButton;
	import flash.text.*;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;

	import flash.net.NetConnection;
	import flash.net.Responder;

	import com.parts.*;
	import com.msgwin.*;
	import gs.TweenLite;
	import gs.OverwriteManager;
	import com.adobe.serialization.json.JSON;



	public class ViewHandlers extends MovieClip {

		public var viewHandleObj:viewHandlers;
		public var effectCls:EffectedParts;
		public var buildPartCls:BuildParts;
		public var partsDetailObj:PartsDetails;
		public var loaderCls:PreLoadAssets;
		public var wallCls:BlackWall;
		public var brosweBtnCls:BrosweButton;
		public var msgCls:MsgWin;
		
		
		
		/*
		************************************************************************************************************
		Constructors
		*/
		public function ViewHandlers() {
			viewHandleObj = new viewHandlers();
			addChild(viewHandleObj);

			effectCls = new EffectedParts();
			addChild(effectCls);

			buildPartCls = new BuildParts();
			addChild(buildPartCls);

			init();
			//addEventListener(Event.ADDED, viewObjectAdded);
		}

		public function reBuildParts():void {
			if (buildPartCls) {
				removeChild(buildPartCls);
				buildPartCls=null;
			}
			buildPartCls = new BuildParts();
			addChild(buildPartCls);
		}

		public function reBuildEffectedParts():void {
			if (effectCls) {
				removeChild(effectCls);
				effectCls=null;
			}
			effectCls = new EffectedParts();
			addChild(effectCls);
		}


		/*public function viewObjectAdded(e:Event):void {
		removeEventListener(Event.ADDED, viewObjectAdded);
		}*/


		
		


		public function showPartsDetails():void {
			partsDetailObj = new PartsDetails();
			addChild(partsDetailObj);

			partsDetailObj.x=1015;
			partsDetailObj.y=465;
		}

		public function reBuildPartsDetails() {
			if (partsDetailObj) {
				removeChild(partsDetailObj);
				partsDetailObj=null;
			}
		}


		public function init():void {

			viewHandleObj.x=1000;
			viewHandleObj.y=200;

			viewHandleObj.frontViewBT.buttonMode=true;
			viewHandleObj.rearViewBT.buttonMode=true;
			viewHandleObj.interiorViewBT.buttonMode=true;
			viewHandleObj.otherViewBT.buttonMode=true;

			//Event Handlers
			viewHandleObj.partUploadBT.addEventListener(MouseEvent.CLICK, partUploadOptions);
			viewHandleObj.frontViewBT.addEventListener(MouseEvent.CLICK, frontViewBTHandler);
			viewHandleObj.rearViewBT.addEventListener(MouseEvent.CLICK, rearViewBTHandler);
			viewHandleObj.interiorViewBT.addEventListener(MouseEvent.CLICK, interiorViewBTHandler);
			viewHandleObj.otherViewBT.addEventListener(MouseEvent.CLICK, otherViewBTHandler);

			viewHandleObj.applyChangesBTN.addEventListener(MouseEvent.CLICK, applyChanges);


			viewHandleObj.applyChangesBTN.mouseEnabled=false;




			viewHandleObj.coordinateMC.savecoord_btn.visible=false;
			viewHandleObj.coordinateMC.editcoord_btn.addEventListener(MouseEvent.CLICK, editCoordiHandler );
			viewHandleObj.coordinateMC.savecoord_btn.addEventListener(MouseEvent.CLICK, saveCoordiHandler );
			viewHandleObj.swapper_btn.addEventListener(MouseEvent.CLICK, swapperHandler );

			wallCls   = new BlackWall();
			addChild(wallCls);


			loaderCls = new PreLoadAssets();
			addChild(loaderCls);

		}//$init



		/*
		*****************************************************************************
		_Actions
		*/
		function swapperHandler(e:MouseEvent) {
			MovieClip(parent.parent.parent).CreateBlackWall();
			swapLoad("Swapper.swf");
		}

		public function applyChanges(e:MouseEvent):void {
			//createNewAccessory($table:String,$vehicle_id:Number,$part_category_id:Number,$part_name:String,$part_manufacturer:String,$description:String,$sku:String,$status:Number,$part_icon:String,$part_price:Number )
			effectCls.partObj.createNewAccessory( buildPartCls.PartLevelType , Main.vehicleID, buildPartCls.PartWheelTypeID , buildPartCls.PartCategoryID ,buildPartCls.PartIsPreview ,buildPartCls.PartLabelTxt ,buildPartCls.PartManufactTxt ,buildPartCls.PartDesTxt,buildPartCls.PartSKUTxt,buildPartCls.PartIsActive, buildPartCls.PartIconImage, buildPartCls.PartPriceTxt , buildPartCls.PartMounthPriceTxt);
			
			reBuildEffectedParts();
			reBuildParts();
			MovieClip(parent.parent.parent).destroyList();
			MovieClip(parent.parent.parent).buildList();
			endsBrosweButtons();
			reBuildPartsDetails();
			
			MovieClip(parent.parent.parent).buildMsgWindow(550);
			MovieClip(parent.parent.parent).msgCls.setMessageWindow( "Confirmation" , "Vehicle Accessory Saved Successfully" , "  OK  " );
			MovieClip(parent.parent.parent).msgCls.addEventListener("winCompleteEvent", accessoryAddedMsg );
		}
		function accessoryAddedMsg(e:WinCompleteEvent):void {
			
			MovieClip(parent.parent.parent).destroyMsgWindow();
		}

		function editCoordiHandler(e:MouseEvent) {
			viewHandleObj.coordinateMC.savecoord_btn.visible=true;
			viewHandleObj.coordinateMC.editcoord_btn.visible=false;
			MovieClip(parent).makeEditAbleCoordinates();
		}

		function saveCoordiHandler(e:MouseEvent) {
			viewHandleObj.coordinateMC.savecoord_btn.visible=false;
			viewHandleObj.coordinateMC.editcoord_btn.visible=true;
			MovieClip(parent).removeEditAble();

			var coordinates_str:String=encodeCoordinates(MovieClip(parent).frontMC.x,MovieClip(parent).frontMC.y,MovieClip(parent).rearMC.x,MovieClip(parent).rearMC.y,MovieClip(parent).interiorMC.x,MovieClip(parent).interiorMC.y,MovieClip(parent).canvesMC_front.x,MovieClip(parent).canvesMC_front.y,MovieClip(parent).canvesMC_rear.x,MovieClip(parent).canvesMC_rear.y,MovieClip(parent).canvesMC_interior.x,MovieClip(parent).canvesMC_interior.y);
			updateCoordinates( MovieClip(parent).vehicle_id , coordinates_str);
		}


		/* View Handlers  */
		function frontViewBTHandler(e:MouseEvent) {
			Main.VIEW_CONTROL_VAR="FVIEW";
			MovieClip(parent).activeTxtObj.activePreviewTxt.text="FRONT VIEW";
			updateApplication(Main.VIEW_CONTROL_VAR);
			frontViewBT();// sub tasks
		}

		function rearViewBTHandler(e:MouseEvent) {
			Main.VIEW_CONTROL_VAR="RVIEW";
			MovieClip(parent).activeTxtObj.activePreviewTxt.text="REAR VIEW";
			updateApplication(Main.VIEW_CONTROL_VAR);
			rearViewBT();// sub tasks
		}

		function interiorViewBTHandler(e:MouseEvent) {
			Main.VIEW_CONTROL_VAR="IVIEW";
			MovieClip(parent).activeTxtObj.activePreviewTxt.text="INTERIOR VIEW";
			updateApplication(Main.VIEW_CONTROL_VAR);
			interiorViewBT();// sub tasks
		}

		function otherViewBTHandler(e:MouseEvent) {
			Main.VIEW_CONTROL_VAR="OVIEW";
			MovieClip(parent).activeTxtObj.activePreviewTxt.text="OTHER VIEW";
			updateApplication(Main.VIEW_CONTROL_VAR);
			otherViewBT();// sub tasks
		}

		// sub tasks functions 
		function frontViewBT() {
			MovieClip(parent).highLightCls.smallBox.y=0;
			with (MovieClip(parent)) {
				canvesMC_front.visible=true;// Load canves 
				canvesMC_rear.visible=false;
				canvesMC_interior.visible=false;
			}
			TweenLite.from(MovieClip(parent).canvesMC_front, 0.50, {alpha:0 });
		}
		function rearViewBT() {
			MovieClip(parent).highLightCls.smallBox.y=132;
			with (MovieClip(parent)) {
				canvesMC_front.visible=false;// Load canves
				canvesMC_rear.visible=true;
				canvesMC_interior.visible=false;
			}
			TweenLite.from(MovieClip(parent).canvesMC_rear, 0.50, {alpha:0 });
		}
		function interiorViewBT() {
			MovieClip(parent).highLightCls.smallBox.y=260;
			with (MovieClip(parent)) {
				canvesMC_front.visible=false;// Load canves
				canvesMC_rear.visible=false;
				canvesMC_interior.visible=true;
			}
			TweenLite.from(MovieClip(parent).canvesMC_interior, 0.50, {alpha:0 });
		}
		function otherViewBT() {
			MovieClip(parent).highLightCls.smallBox.y=260;
			with (MovieClip(parent)) {
				canvesMC_front.visible=false;// Load canves
				canvesMC_rear.visible=false;
				canvesMC_interior.visible=true;
			}
			TweenLite.from(MovieClip(parent).canvesMC_interior, 0.50, {alpha:0 });
		}








		// build Part Forms
		function partUploadOptions(e:MouseEvent) {
			MovieClip(parent.parent.parent).CreateBlackWall();
			isPartSetExist(Main.vehicleID);
		}




		/*
		*********************************************************************************************************
		Views Updates Handlers
		*/
		function updateApplication(VIEW_CONTROL_VAR) {
			if (effectCls.partObj) {
				effectCls.partObj.updateApplication(VIEW_CONTROL_VAR);
				effectCls.partObj.currTool.target=null;


				if (brosweBtnCls) {  // if broswe buttons created
					if (buildPartCls.isSinglePart) {
						switch (VIEW_CONTROL_VAR) {
							case 'FVIEW' :
								brosweBtnCls.FrontVIEW_Checker(effectCls.partObj.frontActive);
								break;
							case 'RVIEW' :
								brosweBtnCls.RearVIEW_Checker(effectCls.partObj.rearActive);
								break;
							case 'IVIEW' :
								brosweBtnCls.InteriorVIEW_Checker(effectCls.partObj.interiorActive);
								break;
							case 'OVIEW' :
								brosweBtnCls.OtherVIEW_Checker(effectCls.partObj.otherActive);
								break;
						}// $switch
					}
				}
			}
		}


		/*
		*********************************************************************************************************
		Remoting
		*/

		function onFault(f:Event ) {
			trace("There was a problem");
		}
		
		function isPartSetExist($vehicle_id:Number) {
			var _service = new NetConnection();
			_service.connect(Main.gateWay);
			var responder=new Responder(is_part_set_exist,onFault);
			_service.call("AddOnCars.isPartsSetExist", responder , $vehicle_id );
		}
		function is_part_set_exist(rs:Object) {
			buildPartCls.partOptionFrmLoad(rs);
		}
		
		
		/* update coordinates */
		function encodeCoordinates(sfviewx,sfviewy,srviewx,srviewy,siviewx,siviewy,cfviewx,cfviewy,crviewx,crviewy,civiewx,civiewy):String {
			var tempArr:Array = new Array();
			var obj:Object = new Object();
			obj.SFVIEWX=sfviewx;
			obj.SFVIEWY=sfviewy;
			obj.SRVIEWX=srviewx;
			obj.SRVIEWY=srviewy;
			obj.SIVIEWX=siviewx;
			obj.SIVIEWY=siviewy;
			obj.CFVIEWX=cfviewx;
			obj.CFVIEWY=cfviewy;
			obj.CRVIEWX=crviewx;
			obj.CRVIEWY=crviewy;
			obj.CIVIEWX=civiewx;
			obj.CIVIEWY=civiewy;
			tempArr.push(obj);
			return JSON.encode(tempArr);
		}
		function updateCoordinates($vehicle_id:Number , $string:String) {
			var _service = new NetConnection();
			_service.connect(Main.gateWay);
			var responder=new Responder(update_coordinates_result,onFault);
			_service.call("AddOnCars.updateCanvesCoordinates", responder , $vehicle_id ,$string);
		}
		function update_coordinates_result(rs:Object) {
			trace(rs);
		}


		/*
		******************************************************************************************************************
		Helper functions
		*/

		public function prepareBroweButtons():void {
			if (!brosweBtnCls) {
				brosweBtnCls = new BrosweButton();
				addChild(brosweBtnCls);
			}			
			
			viewHandleObj.applyChangesBTN.mouseEnabled=true;
			viewHandleObj.partUploadBT.mouseEnabled=false;
		}
		
		
		public function endsBrosweButtons():void{
			if (brosweBtnCls) {
				removeChild(brosweBtnCls);
				brosweBtnCls=null;
			}
			
			viewHandleObj.applyChangesBTN.mouseEnabled=false;
			viewHandleObj.partUploadBT.mouseEnabled=true;
			MovieClip(parent.parent.parent).breadCls.disableToolkitButton();
		}



		// Swappers form
		public var swapLoader:Loader;
		public var swapMC:MovieClip;


		function swapLoad(url:String) {
			swapLoader = new Loader();
			swapLoader.load(new URLRequest(url));
			swapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, swapFrmLoaded);
			MovieClip(parent.parent.parent).buildPreloader();
			MovieClip(parent.parent.parent).loaderCls.pleaseWait("Loading Accessory Swapper Form...");
		}
		function swapFrmLoaded(e:Event):void {
			MovieClip(parent.parent.parent).buildFormContainer();

			swapMC = new MovieClip();
			swapMC=e.currentTarget.content as MovieClip;
			MovieClip(parent.parent.parent).formContainer.addChild(swapMC);
			swapMC.x=200;
			swapMC.y=160;

			swapMC.vehicle_id_txt.text=Main.vehicleID;

			swapMC.close_btn.addEventListener(MouseEvent.CLICK, onSwapFrmClose );
			MovieClip(parent.parent.parent).destroyPreLoader();
		}

		function onSwapFrmClose(event:MouseEvent) {
			wallCls.removeBlackWall();
			removeSwapperFrm();
		}
		function removeSwapperFrm() {
			swapLoader.unload();
			MovieClip(parent.parent.parent).formContainer.removeChild(swapMC);
			swapMC=null;
			MovieClip(parent.parent.parent).destroyBlackWall();
			MovieClip(parent.parent.parent).destroyFormContainer();
		}






	}//$class
}//$package