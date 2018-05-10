<?php
class ControllerExtensionModulepavcategorybanner extends Controller {

	private $error = array(); 
	private $mdata = array();
	
	public function index() {   
		
		$this->load->language('extension/module/pavcategorybanner');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');

		$this->load->model('extension/module');

		$this->load->model('tool/image');

		$this->mdata['objlang'] = $this->language;
		$this->mdata['objurl'] = $this->url;
		$this->mdata['objtool'] = $this->model_tool_image;

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
	
			$this->session->data['success'] = $this->language->get('text_success');
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('pavcategorybanner', $this->request->post['pavcategorybanner_module']);
				$this->response->redirect( $this->url->link('extension/module/pavcategorybanner', 'token=' . $this->session->data['token'], 'SSL') );
			} else {

				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post['pavcategorybanner_module']);
				$this->response->redirect( $this->url->link('extension/module/pavcategorybanner', 'token=' . $this->session->data['token'].'&module_id='.$this->request->get['module_id'], 'SSL') );
			}
		}
				
		$this->_languages();
 		$this->_alert();
 		$this->_breadcrumbs();

 		// Get Store
 		$this->mdata['stores'] = $this->_getStores();
		$store_id = isset($this->request->get['store_id'])?$this->request->get['store_id']:0;
		$this->mdata['store_id'] = $store_id;

 		// Data module
 		$this->_dataModule();
		
		// Get Data Category
		$this->load->model('catalog/category');
		$results = $this->model_catalog_category->getCategories( array('limit' => 999999999 , 'start'=>0 ) );
		$this->mdata['product_categories'] = $results; 

		// Get Data Tabs
		$tabs = array(
			'latest' 	 => $this->language->get('text_latest'),
			'featured'   => $this->language->get('text_featured'),
			'bestseller' => $this->language->get('text_bestseller'),
			'special'   => $this->language->get('text_special'),
			'mostviewed' => $this->language->get('text_mostviewed')
		);	
		$this->mdata['tabs'] = $tabs;

		// Render
		$this->mdata['header'] = $this->load->controller('common/header');
		$this->mdata['column_left'] = $this->load->controller('common/column_left');
		$this->mdata['footer'] = $this->load->controller('common/footer');

		$template = 'extension/module/pavcategorybanner.tpl';
		$this->response->setOutput($this->load->view($template, $this->mdata));
	}

	public function _dataModule(){
		// Module ID
		if (isset($this->request->get['module_id'])) {
			$module_id = $this->request->get['module_id'];
			$url = '&module_id='.$module_id;
		} else {
			$module_id = '';
			$url = '';
		}
		$this->mdata['module_id'] = $module_id;

		// action
		$this->mdata['delete'] = $this->url->link('extension/module/pavcategorybanner/ndelete', 'token=' . $this->session->data['token'].$url, 'SSL');
		$this->mdata['action'] = $this->url->link('extension/module/pavcategorybanner', 'token=' . $this->session->data['token'].$url, 'SSL');

		$this->mdata['extensions'] = $this->module("pavcategorybanner");

		// GET DATA SETTING
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		$this->mdata['module'] = array();
		// status
		if (isset($this->request->post['pavcategorybanner']['status'])) {
			$this->mdata['module']['status'] = $this->request->post['pavcategorybanner']['status'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['status'] = $module_info['status'];
		} else {
			$this->mdata['module']['status'] = 1;
		}
		// name
		if (isset($this->request->post['pavcategorybanner']['name'])) {
			$this->mdata['module']['name'] = $this->request->post['pavcategorybanner']['name'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['name'] = $module_info['name'];
		} else {
			$this->mdata['module']['name'] = '';
		}
		// width
		if (isset($this->request->post['pavcategorybanner']['width'])) {
			$this->mdata['module']['width'] = $this->request->post['pavcategorybanner']['width'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['width'] = $module_info['width'];
		} else {
			$this->mdata['module']['width'] = 300;
		}
		// height
		if (isset($this->request->post['pavcategorybanner']['height'])) {
			$this->mdata['module']['height'] = $this->request->post['pavcategorybanner']['height'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['height'] = $module_info['height'];
		} else {
			$this->mdata['module']['height'] = 300;
		}
		// itemsperpage
		if (isset($this->request->post['pavcategorybanner']['itemsperpage'])) {
			$this->mdata['module']['itemsperpage'] = $this->request->post['pavcategorybanner']['itemsperpage'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['itemsperpage'] = $module_info['itemsperpage'];
		} else {
			$this->mdata['module']['itemsperpage'] = 4;
		}
		// cols
		if (isset($this->request->post['pavcategorybanner']['cols'])) {
			$this->mdata['module']['cols'] = $this->request->post['pavcategorybanner']['cols'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['cols'] = $module_info['cols'];
		} else {
			$this->mdata['module']['cols'] = 4;
		}
		//limit
		if (isset($this->request->post['pavcategorybanner']['limit'])) {
			$this->mdata['module']['limit'] = $this->request->post['pavcategorybanner']['limit'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['limit'] = $module_info['limit'];
		} else {
			$this->mdata['module']['limit'] = 4;
		}
		//category_tabs
		if (isset($this->request->post['pavcategorybanner']['category_tabs'])) {
			$this->mdata['module']['category_tabs'] = $this->request->post['pavcategorybanner']['category_tabs'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['category_tabs'] = isset($module_info['category_tabs'])?$module_info['category_tabs']:array();
		} else {
			$this->mdata['module']['category_tabs'] = '';
		}
		//image
		if (isset($this->request->post['pavcategorybanner']['image'])) {
			$this->mdata['module']['image'] = $this->request->post['pavcategorybanner']['image'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['image'] = isset($module_info['image'])?$module_info['image']:array();
		} else {
			$this->mdata['module']['image'] = '';
		}
		//class
		if (isset($this->request->post['pavcategorybanner']['class'])) {
			$this->mdata['module']['class'] = $this->request->post['pavcategorybanner']['class'];
		} elseif (!empty($module_info)) {
			$this->mdata['module']['class'] = isset($module_info['class'])?$module_info['class']:array();
		} else {
			$this->mdata['module']['class'] = '';
		}
	}

	public function ndelete(){
		$this->load->model('extension/module');
		$this->load->language('extension/module/pavcategorybanner');
		if (isset($this->request->get['module_id'])) {
			$this->model_extension_module->deleteModule($this->request->get['module_id']);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('extension/module/pavcategorybanner', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	public function module($extension){
		$module_data = array();
		$this->load->model('extension/extension');
		$this->load->model('extension/module');
		$extensions = $this->model_extension_extension->getInstalled('module');
		$modules = $this->model_extension_module->getModulesByCode($extension);
		foreach ($modules as $module) {
			$module_data[] = array(
				'module_id' => $module['module_id'],
				'name'      => $module['name'],
				'edit'      => $this->url->link('extension/module/pavcategorybanner', 'token=' . $this->session->data['token'] . '&module_id=' . $module['module_id'], 'SSL'),
			);
		}
		$ex[] = array(
			'name'      => $this->language->get("create_module"),
			'module'    => $module_data,
			'edit'      => $this->url->link('extension/module/pavcategorybanner', 'token=' . $this->session->data['token'], 'SSL')
		);
		return $ex;
	}

	public function _alert(){
		if (isset($this->error['warning'])) {
			$this->mdata['error_warning'] = $this->error['warning'];
		} else {
			$this->mdata['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->mdata['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->mdata['success'] = '';
		}
		
		if (isset($this->error['dimension'])) {
			$this->mdata['error_dimension'] = $this->error['dimension'];
		} else {
			$this->mdata['error_dimension'] = array();
		}
	}

	public function _getStores(){

		$this->load->model('setting/store');

		$action = array();
		$action[] = array(
			'text' => $this->language->get('text_edit'),
			'href' => $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL')
		);
		$store_default = array(
			'store_id' => 0,
			'name'     => $this->config->get('config_name') . $this->language->get('text_default'),
			'url'      => HTTP_CATALOG,
		);
		$stores = $this->model_setting_store->getStores();
		array_unshift($stores, $store_default);
		
		foreach ($stores as &$store) {
			$url = '';
			if ($store['store_id'] > 0 ) {
				$url = '&store_id='.$store['store_id'];
			}
			$store['option'] = $this->url->link('extension/module/pavcategorybanner', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		return $stores;
	}

	public function _breadcrumbs(){
		$this->mdata['breadcrumbs'] = array();

   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token'].'&type=module', 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->mdata['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/pavcategorybanner', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
	}

	public function _languages(){
		$this->mdata['heading_title'] = $this->language->get('heading_title');
		$this->mdata['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->mdata['text_browse'] = $this->language->get('text_browse');
		$this->mdata['text_clear'] = $this->language->get('text_clear');	
		$this->mdata['no_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$this->mdata['text_enabled'] = $this->language->get('text_enabled');
		$this->mdata['text_disabled'] = $this->language->get('text_disabled');
		$this->mdata['text_content_top'] = $this->language->get('text_content_top');
		$this->mdata['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->mdata['text_column_left'] = $this->language->get('text_column_left');
		$this->mdata['text_column_right'] = $this->language->get('text_column_right');
		$this->mdata['entry_description'] = $this->language->get('entry_description');
		$this->mdata['entry_tabs'] = $this->language->get('entry_tabs');
		$this->mdata['entry_banner'] = $this->language->get('entry_banner');
		$this->mdata['entry_dimension'] = $this->language->get('entry_dimension'); 
		$this->mdata['entry_carousel'] = $this->language->get('entry_carousel'); 

		$this->mdata['entry_item'] = $this->language->get('entry_item');
		$this->mdata['entry_module_name'] = $this->language->get('entry_module_name');

		$this->mdata['entry_layout'] = $this->language->get('entry_layout');
		$this->mdata['entry_position'] = $this->language->get('entry_position');
		$this->mdata['entry_status'] = $this->language->get('entry_status');
		$this->mdata['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->mdata['entry_category'] = $this->language->get( 'entry_category' );

		$this->mdata['button_save'] = $this->language->get('button_save');
		$this->mdata['button_cancel'] = $this->language->get('button_cancel');
		$this->mdata['button_add_module'] = $this->language->get('button_add_module');
		$this->mdata['button_remove'] = $this->language->get('button_remove');
		
		$this->load->model('localisation/language');
		$this->mdata['tab_module'] = $this->language->get('tab_module');
		$this->mdata['languages'] = $this->model_localisation_language->getLanguages();
		$this->mdata['token'] = $this->session->data['token'];

		$this->mdata['action'] = $this->url->link('extension/module/pavcategorybanner', 'token=' . $this->session->data['token'], 'SSL');
		$this->mdata['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'].'&type=module', 'SSL');
		
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/pavcategorybanner')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (isset($this->request->post['pavproducts_module'])) {
			foreach ($this->request->post['pavproducts_module'] as $key => $value) {
				if (!$value['width'] || !$value['height']) {
					$this->error['dimension'][$key] = $this->language->get('error_dimension');
				}

				if( !isset($value['category_tabs']) ){
					$this->error['dimension'][$key] = $this->language->get('error_category_tabs');

				}		
			}
		}	
						
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
