package com.main{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.FileReference;
	import flash.net.FileFilter;

	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import com.msgwin.*;

	public class BuildParts extends MovieClip {
		
		
		
		public var isPartOnCanves:Boolean=false;
		public var isSinglePart:Boolean=false;
		public var optionLoader:Loader;
		public var createSetLoader:Loader;
		public var addAccessoryFrmLoader:Loader;

		public var optionFrmMC:MovieClip;
		public var createSetFrmMC:MovieClip;
		public var addAccessoryFrm:MovieClip;


		public var PartLevelType:String='';
		public var PartLabelTxt:String='';
		public var PartSKUTxt:String='';
		public var PartPriceTxt:Number=0;
		public var PartMounthPriceTxt:Number=0;
		public var PartDesTxt:String='';
		public var PartIconImage:String='';

		public var PartIsActive:Number=0;
		public var PartIsPreview:Number=0;

		public var PartManufactTxt:String='';
		public var PartTypeID:Number;
		public var PartCategoryID:Number;
		public var PartWheelTypeID:Number;


		/*
		**********************************************************************
		Contrutors
		*/
		public function BuildParts() {
		}

		/*
		**********************************************************************
		Remoting
		*/
		function createPartSet($vehicle_id:Number,$part_category_id:Number,$part_name:String, $part_manufacturer:String,$description:String,$sku:String,$status:Number,$part_icon:String,$part_price:Number,$montlyPrice:Number,$set_ids:String):void {
			var myService = new NetConnection();
			myService.connect(Main.gateWay);
			var responder=new Responder(get_set_result,onFault);
			myService.call("AddOnCars.insertPartSet", responder , $vehicle_id , $part_category_id ,  $part_name, $part_manufacturer,$description,$sku,$status,$part_icon,$part_price, $montlyPrice , $set_ids );
		}
		function get_set_result(rs:Object) {
			if(rs){
				MovieClip(parent.parent.parent.parent).buildMsgWindow();
				MovieClip(parent.parent.parent.parent).msgCls.setMessageWindow( "Confirmation" , "Vehicle Accessory Set Created Successfully" , "  OK  " );
				MovieClip(parent.parent.parent.parent).msgCls.addEventListener("winCompleteEvent", accessorySetCreatedMsg );
				MovieClip(parent.parent.parent.parent).destroyList();
				MovieClip(parent.parent.parent.parent).buildList();
			}else{
				trace("Error: in insering parts set");
			}
		}
		function accessorySetCreatedMsg(e:WinCompleteEvent):void {
			MovieClip(parent.parent.parent.parent).destroyMsgWindow();
		}
		
		function removeSetPart($vehicle_id:Number) {
			var _service = new NetConnection();
			_service.connect(Main.gateWay);
			var responder=new Responder(remove_partset_result,onFault);
			_service.call("AddOnCars.removePartsSet", responder , $vehicle_id );
		}
		function remove_partset_result(rs:Object) {
			if(rs){
				optionFrmMC.createRadioButtons(false);
			}
		}
		
		
		public function onFault(f:Event ) {
			trace("There was a problem");
		}

		/*
		**********************************************************************
		Parts Forms
		*/


		public var isSetExist:Boolean = false;
		// options frm
		function partOptionFrmLoad($state:Boolean) {
			isSetExist = $state;
			optionLoader = new Loader();
			var mRequest:URLRequest=new URLRequest("part-option.swf");
			optionLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onOptionFrmLoaded);
			optionLoader.load(mRequest);
			MovieClip(parent.parent.parent.parent).buildPreloader();
			MovieClip(parent.parent.parent.parent).loaderCls.pleaseWait("Loading Accessories Option Form...");
		}
		function onOptionFrmLoaded(e:Event) {
			MovieClip(parent.parent.parent.parent).buildFormContainer();

			optionFrmMC = new MovieClip();
			optionFrmMC=e.currentTarget.content as MovieClip;

			MovieClip(parent.parent.parent.parent).formContainer.addChild(optionFrmMC);
			optionFrmMC.x=310;
			optionFrmMC.y=260;

			optionFrmMC.submit_btn.addEventListener(MouseEvent.CLICK, selectOptionFrmSbt);
			optionFrmMC.close_btn.addEventListener(MouseEvent.CLICK, closeOptionFrm);
			MovieClip(parent.parent.parent.parent).destroyPreLoader();
			
			if(isSetExist){
				optionFrmMC.createRadioButtons(true);
			}else{
				 optionFrmMC.createRadioButtons(false);
			}
		}

		function selectOptionFrmSbt(event:MouseEvent) {
						
			switch(optionFrmMC.frmOption.selection.value){
				case 1:
					  removeOptionFrm();
					  partFormLoad();
					  break;
				case 2:
					  removeOptionFrm();
					  buildSetFrmLoad();				
					  break;
				case 3:
				      MovieClip(parent.parent.parent.parent).buildMsgWindow();
					  MovieClip(parent.parent.parent.parent).msgCls.setMessageWindow( "Confirmation" , "Are You Sure To Remove Parts Set" , "  YES  " );
					  MovieClip(parent.parent.parent.parent).msgCls.addEventListener("winCompleteEvent", removePartsSetResponse );
					  break;
			}
		}
		function removePartsSetResponse(e:WinCompleteEvent):void {
			if(MsgWin.winResponse){
				removeSetPart(Main.vehicleID);
			}
			MovieClip(parent.parent.parent.parent).destroyMsgWindow();
		}
		
		
		function closeOptionFrm(event:MouseEvent) {
			removeOptionFrm();
			MovieClip(parent.parent.parent.parent).destroyBlackWall();
		}
		function removeOptionFrm() {
			optionLoader.unload();
			MovieClip(parent.parent.parent.parent).formContainer.removeChild(optionFrmMC);
			optionFrmMC=null;
			MovieClip(parent.parent.parent.parent).destroyFormContainer();
		}


		// Build Sets
		var buidStr:String='';
		var buildSetLoader:Loader;
		var buildSetFrmMC:MovieClip;

		function buildSetFrmLoad() {
			buildSetLoader = new Loader();
			var mRequest:URLRequest=new URLRequest("build-set.swf");
			buildSetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBuildSetFrmLoaded);
			buildSetLoader.load(mRequest);
			MovieClip(parent.parent.parent.parent).buildPreloader();
			MovieClip(parent.parent.parent.parent).loaderCls.pleaseWait("Loading Vehicles Accessories Sets Form...");
		}
		function onBuildSetFrmLoaded(e:Event) {
			MovieClip(parent.parent.parent.parent).buildFormContainer();

			buildSetFrmMC = new MovieClip();
			buildSetFrmMC=e.currentTarget.content as MovieClip;

			MovieClip(parent.parent.parent.parent).formContainer.addChild(buildSetFrmMC);
			buildSetFrmMC.x=310;
			buildSetFrmMC.y=100;

			buildSetFrmMC.submit_btn.addEventListener(MouseEvent.CLICK, selectBuildSetFrmSbt);
			buildSetFrmMC.close_btn.addEventListener(MouseEvent.CLICK, closeBuildSetFrm);
			MovieClip(parent.parent.parent.parent).destroyPreLoader();

			buildSetFrmMC.vehicle_id_txt.text=Main.vehicleID;
		}

		function selectBuildSetFrmSbt(event:MouseEvent) {
			buidStr='';
			//id-lbl-price1-price2-applied
			if (buildSetFrmMC.done_parts_list.length>0) {
				for (var i:Number = 0; i < buildSetFrmMC.done_parts_list.length; i++) {
					buidStr += buildSetFrmMC.done_parts_list.getItemAt(i).data+",";
				}
				removeBuildSetFrm();
				createSetLoad();
			} else {
				buildSetFrmMC.msg_txt.visible=true;
			}
		}

		function closeBuildSetFrm(event:MouseEvent) {
			removeBuildSetFrm();
			MovieClip(parent.parent.parent.parent).destroyBlackWall();
		}
		function removeBuildSetFrm() {
			buildSetLoader.unload();
			MovieClip(parent.parent.parent.parent).formContainer.removeChild(buildSetFrmMC);
			buildSetFrmMC=null;
			MovieClip(parent.parent.parent.parent).destroyFormContainer();
		}


		//  ADD SET OF PARTS FORM
		function createSetLoad() {
			createSetLoader = new Loader();
			var mRequest:URLRequest=new URLRequest("add-set.swf");
			createSetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCreateSetFrmLoaded);
			createSetLoader.load(mRequest);
			MovieClip(parent.parent.parent.parent).buildPreloader();
			MovieClip(parent.parent.parent.parent).loaderCls.pleaseWait("Loading Vehicles Accessories Create Set Form...");
		}
		function onCreateSetFrmLoaded(e:Event) {
			MovieClip(parent.parent.parent.parent).buildFormContainer();

			createSetFrmMC = new MovieClip();
			createSetFrmMC = e.currentTarget.content as MovieClip;

			MovieClip(parent.parent.parent.parent).formContainer.addChild(createSetFrmMC);
			createSetFrmMC.x=310;
			createSetFrmMC.y=50;

			createSetFrmMC.submit_btn.addEventListener(MouseEvent.CLICK, selectCreateSetFrmSbt);
			createSetFrmMC.close_btn.addEventListener(MouseEvent.CLICK, closeCreateSetFrm);
			createSetFrmMC.backStepBtn.addEventListener(MouseEvent.CLICK, onCreateSetFrmBack );

			createSetFrmMC.idsArr_txt.text      = buidStr;
			createSetFrmMC.vehicle_id_txt.text  = Main.vehicleID;
			MovieClip(parent.parent.parent.parent).destroyPreLoader();
		}

		function onCreateSetFrmBack(event:MouseEvent) {
			buildSetFrmLoad();
			removeCreateSetFrm();
		}


		function selectCreateSetFrmSbt(event:MouseEvent) {

			if (createSetFrmMC.validateCreateSets()) {
				
				PartCategoryID = createSetFrmMC.part_category.selectedItem.data;
				
				
				var setIds:String='';
				for (var i:Number = 0; i < createSetFrmMC.parts_list.length; i++) {
					setIds += createSetFrmMC.parts_list.getItemAt(i).data + ",";
				}
				var status_txt:Number=0;
				if (createSetFrmMC.isActives.selected) {
					status_txt = 1;
				}

				var lbl_txt:String         = createSetFrmMC.label_txt.text;
				var sku_txt:String         = createSetFrmMC.sku_txt.text;
				var manufacture_txt:String = createSetFrmMC.part_manufacturer.selectedItem.label;
				var des:String             = createSetFrmMC.des_txt.text;

				var price:Number      = createSetFrmMC.pricetxt.text;
				var monthPrice:Number = createSetFrmMC.month_price_txt.text;
				var img_icon:String   = createSetFrmMC.part_iconimg_txt.text;
				
				//id-lbl-price1-price2-applied
				//createPartSet($vehicle_id:Number,$part_category_id:Number,$part_name:String, $part_manufacturer:String,$description:String,$sku:String,$status:Number,$part_icon:String,$part_price:Number,$montlyPrice:Number,$set_ids:String)
				createPartSet(Main.vehicleID ,PartCategoryID,lbl_txt, manufacture_txt ,des,sku_txt,status_txt,img_icon,price,monthPrice,buidStr);

				removeCreateSetFrm();
				MovieClip(parent.parent.parent.parent).destroyBlackWall();
			} else {
				createSetFrmMC.msg_txt.visible=true;
			}

		}

		function closeCreateSetFrm(event:MouseEvent) {
			removeCreateSetFrm();
			MovieClip(parent.parent.parent.parent).destroyBlackWall();
		}
		function removeCreateSetFrm() {
			createSetLoader.unload();
			MovieClip(parent.parent.parent.parent).formContainer.removeChild(createSetFrmMC);
			createSetFrmMC=null;
			MovieClip(parent.parent.parent.parent).destroyFormContainer();
		}



		// Single Part Form
		function partFormLoad() {
			addAccessoryFrmLoader = new Loader();
			var mRequest:URLRequest=new URLRequest("add-parts.swf");
			addAccessoryFrmLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			addAccessoryFrmLoader.load(mRequest);
			MovieClip(parent.parent.parent.parent).buildPreloader();
			MovieClip(parent.parent.parent.parent).loaderCls.pleaseWait("Loading Vehicles Single Accessory Form...");
		}
		function onCompleteHandler(e:Event) {
			MovieClip(parent.parent.parent.parent).buildFormContainer();

			addAccessoryFrm = new MovieClip();
			addAccessoryFrm=e.currentTarget.content as MovieClip;

			MovieClip(parent.parent.parent.parent).formContainer.addChild(addAccessoryFrm);
			addAccessoryFrm.x=310;
			addAccessoryFrm.y=160;

			addAccessoryFrm.partadd_btn.addEventListener(MouseEvent.CLICK, addAccessoryFormSbt);
			addAccessoryFrm.close_btn.addEventListener(MouseEvent.CLICK, closePartForm);
			MovieClip(parent.parent.parent.parent).destroyPreLoader();
		}

		function addAccessoryFormSbt(event:MouseEvent) {
			if (addAccessoryFrm.label_txt.length>0&&addAccessoryFrm.des_txt.length>2&&addAccessoryFrm.checkFields(addAccessoryFrm.sku_txt)&&addAccessoryFrm.checkFields(addAccessoryFrm.price_txt)&&addAccessoryFrm.checkFields(addAccessoryFrm.part_iconimg_txt)&&addAccessoryFrm.matchDropDowns(addAccessoryFrm.part_manufacturer,addAccessoryFrm.part_type,addAccessoryFrm.part_category,addAccessoryFrm.wheelMC.wheel_category)) {
				isSinglePart=true;// key for view handlers
				getPartDetails();
				removePartsForm();
				MovieClip(parent).prepareBroweButtons();
				MovieClip(parent).showPartsDetails();
				setPartsDetailData();
				MovieClip(parent.parent.parent.parent).destroyBlackWall();

			} else {
				addAccessoryFrm.msg_txt.visible=true;
			}
		}

		public function setPartsDetailData():void {
			// set PartsDetails Text fields
			with (MovieClip(parent).partsDetailObj) {
				part_lbl_txt.text=PartLabelTxt;
				sku_lbl_txt.text=PartSKUTxt;
				price_lbl_txt.text="$"+PartPriceTxt;
				des_lbl_txt.text=PartDesTxt;
			}
			// set toolkit button on breadcrumb
			if (PartIsPreview==1) {
				MovieClip(parent.parent.parent.parent).breadCls.enableToolkitButton();
				MovieClip(parent).updateApplication(Main.VIEW_CONTROL_VAR);
			}
		}

		function getPartDetails() {

			PartLevelType=addAccessoryFrm.validationType;
			PartLabelTxt=addAccessoryFrm.label_txt.text;
			PartSKUTxt=addAccessoryFrm.sku_txt.text;
			PartPriceTxt=addAccessoryFrm.price_txt.text;
			PartMounthPriceTxt=addAccessoryFrm.month_price_txt.text;
			PartDesTxt=addAccessoryFrm.des_txt.text;
			PartIconImage=addAccessoryFrm.part_iconimg_txt.text;

			if (addAccessoryFrm.isActives.selected) {
				PartIsActive=1;
			}
			if (addAccessoryFrm.accessory_preview.selected) {
				PartIsPreview=0;
			} else {
				isPartOnCanves==true;// global variable
				PartIsPreview=1;
				//updateApplication(VIEW_CONTROL_VAR);
			}

			PartManufactTxt=addAccessoryFrm.part_manufacturer.selectedItem.label;
			PartTypeID=addAccessoryFrm.part_type.selectedItem.data;
			PartCategoryID=addAccessoryFrm.part_category.selectedItem.data;
			if (PartLevelType=='w') {
				PartWheelTypeID=addAccessoryFrm.wheelMC.wheel_category.selectedItem.data;
			}

		}
		function closePartForm(event:MouseEvent) {
			removePartsForm();
			MovieClip(parent.parent.parent.parent).destroyBlackWall();
		}
		function removePartsForm() {
			addAccessoryFrmLoader.unload();
			MovieClip(parent.parent.parent.parent).formContainer.removeChild(addAccessoryFrm);
			addAccessoryFrm=null;
			MovieClip(parent.parent.parent.parent).destroyFormContainer();
		}



	}//$class
}//$package