<?php
class ControllerExtensionModulepavcategorybanner extends Controller {
	
	private $mdata = array();

	public function index($setting) {
		static $module = 0;

		$this->load->model('catalog/product'); 
		$this->load->model('catalog/category'); 
		$this->load->model('tool/image');
		$this->load->language('extension/module/pavcategorybanner');

		$languageID = $this->config->get('config_language_id');

		$this->mdata['objlang'] = $this->language;
		$this->mdata['objurl'] = $this->url;
		$this->mdata['objtool'] = $this->model_tool_image;

		$default = array(
			'width'         => 202,
			'height'        => 168,
			'category_tabs' => array(),
			'image'         => array(),
			'itemsperpage'  => 6,
			'cols'          => 3,
			'limit'         => 12,
		);

		$data  = array_merge($default, $setting);

		$this->mdata['itemsperpage'] = $data['itemsperpage'];
		$this->mdata['cols'] = $data['cols'];
		$this->mdata['limit'] = $data['limit'];

		//List image categories
		$catimgs = $data['image'];

		if(empty($data['category_tabs'])){
			return ;
		}
		
		foreach ($data['category_tabs'] as $key=>$category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if($catimgs[$key]){
				$image = $this->model_tool_image->resize($catimgs[$key], $data['width'], $data['height']);
			} else {
				$image = false;
			}

			$datap = array(
				'filter_category_id'  => $category_info['category_id'],
				'filter_sub_category' => true
			);

			$product_total = $this->model_catalog_product->getTotalProducts($datap);

			if ($category_info) {
				$categories[$category_id]['parent'] = array(
					'image' => $image,
					'href' => $this->url->link('product/category', 'path=' . $category_info['category_id'])	,
					'name' =>(isset($category_info['path']) ? $category_info['path'] . ' &gt; ' : '') . $category_info['name'],
					'count' => $product_total,
				);
			}
			//$categories[$category_id]['haschild'] = $this->rendercategory($category_id);
		}

		$this->mdata['categories']   = $categories;

		$this->mdata['module'] = $module++;					

		$template = 'extension/module/pavcategorybanner';

		return $this->load->view($template, $this->mdata);
	}

	public function rendercategory($category_id) {
		$this->load->model('catalog/category');
		$categories = $this->model_catalog_category->getCategories($category_id);

		$result = array();

		foreach ($categories as $category) {
			$total = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $category['category_id']));

			$children_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			foreach ($children as $child) {
				$data = array(
					'filter_category_id'  => $child['category_id'],
					'filter_sub_category' => true
				);

				$product_total = $this->model_catalog_product->getTotalProducts($data);

				$total += $product_total;

				$children_data[] = array(
					'category_id' => $child['category_id'],
					'name'        => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
					'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])	
				);		
			}

			$result[] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $total . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);	
		}

		return $result;
	}
}
?>