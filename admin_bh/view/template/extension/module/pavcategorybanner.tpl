<?php 
	echo $header; 
	echo $column_left;
?>
<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<a class="btn btn-primary" onclick="$('#form').submit();"><?php echo $button_save; ?></a>

				<?php if(!empty($module_id)) { ?>
				<a onclick="confirm('Are you sure?') ? location.href='<?php echo $delete; ?>' : false;" data-toggle="tooltip" title="" class="btn btn-danger" data-original-title="Delete">Delete</a>
				<?php } ?>

				<a class="btn btn-default" href="<?php echo $cancel; ?>" data-toggle="tooltip" data-original-title="<?php echo $button_cancel; ?>" title=""><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div><!-- End div#page-header -->

	<div id="page-content" class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
			<?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if (isset($success) && !empty($success)) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
			</div>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
				<div class="panel-body">

					<!-- Modules -->
					<div class="row">
						<div class="col-sm-2">
							<ul class="nav nav-pills nav-stacked">
								<?php if ($extensions) { ?>
								<?php foreach ($extensions as $extension) { ?>
								<?php $actived = (empty($module_id))?"class='active'":''; ?>
								<li <?php echo $actived; ?>><a href="<?php echo $extension['edit']; ?>" ><i class="fa fa-plus-circle"></i> <?php echo $extension['name']; ?></a></li>
								<?php $i=0; foreach ($extension['module'] as $m) { $i++;?>
								<?php $active = ($m['module_id'] == $module_id)?'class="active"':''; ?>
								<li <?php echo $active; ?>><a href="<?php echo $m['edit']; ?>" ><i class="fa fa-plus-circle"></i> <?php echo $m['name']; ?></a></li>
								<?php } //end modules?>
								<?php } //end extensions?>
								<?php } //end if?>
							</ul>
						</div> <!-- End UL TAB -->
						<div class="col-sm-10">
							<div class="pull-left">
								
								
							</div>
							<div class="tab-content" id="tab-content">
							
								<div class="tab-pane active" id="tab-module-pavcategorybanner">
									<table class="table">
										<tr class="no-border">
											<td class="col-sm-2"><?php echo $entry_status; ?></td>
											<td class="col-sm-10">
												<select class="form-control no-style" name="pavcategorybanner_module[status]">
													<?php if ($module['status']) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select><br>
											</td>
										</tr>
										<tr>
											<td class="col-sm-2"><?php echo $entry_module_name; ?></td>
											<td class="col-sm-10"><input class="form-control no-style" type="text" placeholder="<?php echo $entry_module_name; ?>" name="pavcategorybanner_module[name]" value="<?php echo $module['name']; ?>"/></td>
										</tr>
										<tr>
											<td class="col-sm-2"><?php echo $entry_dimension; ?></td>
											<td class="col-sm-10"><input class="form-control no-style" type="text" name="pavcategorybanner_module[width]" value="<?php echo $module['width']; ?>"/> x <input class="form-control no-style" type="text" name="pavcategorybanner_module[height]" value="<?php echo $module['height']; ?>"/></td>
										</tr>
										</tr>
											<td class="col-sm-2"><?php echo $entry_item; ?></td>
											<td class="col-sm-10"><input class="form-control no-style" type="text" name="pavcategorybanner_module[itemsperpage]" value="<?php echo $module['itemsperpage']; ?>"/> - <input class="form-control no-style" type="text" name="pavcategorybanner_module[cols]" value="<?php echo $module['cols']; ?>"/> - <input class="form-control no-style" type="text" name="pavcategorybanner_module[limit]" value="<?php echo $module['limit']; ?>"/></td>
										</tr>
									</table>
									<div class="category-tabs">
										<a data-toggle="tooltip" class="btn btn-success btn-sm" data-original-title="<?php echo $objlang->get('text_add_category');?>" onclick="addCategoryTab('category-tabs-1',1)"><i class="fa fa-plus-circle"></i></a>
										<div id='category-tabs-1'>
											<!-- start -->
											<?php if( isset($module['category_tabs']) && $module['category_tabs'] ) {  ?>
											<?php foreach( $module['category_tabs'] as $idx => $category ) { ?>
											<table class="table" id="category-tab-wrapper<?php echo $idx+1;?>">
												<tr class="no-border">
													<td><?php echo $objlang->get('entry_category');?></td>
													<td>
														<select class="form-control" name="pavcategorybanner_module[category_tabs][]">
															<?php foreach( $product_categories as $category){ ?>
															<option <?php if( $module['category_tabs'][$idx] == $category['category_id'] ) {?>selected="selected"<?php } ?> value="<?php echo $category['category_id'];?>"><?php echo addslashes($category['name']);?> [ID:<?php echo $category['category_id'];?>]</option>
															<?php } ?>
														</select>
													</td>
													<td><?php echo $objlang->get('entry_icon_image');?></td>

													<td>
														<?php 
															$banner_row = "-".$idx;
															$thumb = isset($module['image'][$idx])?$objtool->resize( $module['image'][$idx], 100, 100):"";
															$image = isset($module['image'][$idx])?$module['image'][$idx]:"";
														?>
														<a href="" id="thumb-image<?php echo $banner_row; ?>" data-toggle="image" class="img-thumbnail">
															<img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $thumb; ?>" />
														</a>
														<input type="hidden" name="pavcategorybanner_module[image][]" value="<?php echo $image; ?>" id="input-image<?php echo $banner_row; ?>" />
													</td> 

													<td><?php echo $objlang->get('entry_addition_class');?></td>
													<td>
														<input class="form-control" type="text" name="pavcategorybanner_module[class][]" value="<?php echo $module['class'][$idx];?>">
													</td>
													<td size="4"><a class="btn btn-danger btn-sm" onclick="$('#category-tab-wrapper<?php echo $idx+1;?>').remove(); return false;"><i class="fa fa-minus-circle"></i></a></td>
												</tr>
											</table>  
											<?php } ?> 
											<?php } ?> 
											<!-- end -->
										</div>		
									</div>
								</div>	

							</div>
						</div> <!-- End DIV CONTENT TAB -->	
					</div>
				</div><!-- End div .panel-body -->
			</form>
		</div>
	</div><!-- End div#page-content -->
</div><!-- End div#content -->

<script type="text/javascript">
// Active Tab Module
$('#module-pavcategorybanner li:first-child a').tab('show');

</script>

<script type="text/javascript">
	function addCategoryTab( wrapper,mid ){
		var index =  $("#"+wrapper+" table").length; 
		var banner_row = mid+ '-'+index;
		var html  = '';
		html  = '<table class="table" id="category-tab-wrapper'+index+'">';
		html += '	<tr class="no-border">';
		html += '		<td><?php echo $objlang->get("entry_category");?></td>';
		html += '		<td>';
		html += '			<select class="form-control" name="pavcategorybanner_module[category_tabs][]">';
								<?php foreach( $product_categories as $category){ ?>
		html += '				<option value="<?php echo $category['category_id'];?>"><?php echo addslashes($category['name']);?> [ID:<?php echo $category['category_id'];?>]</option>';
								<?php } ?>
		html += '			</select>';
		html += '		</td>';
		html += '		<td><?php echo $objlang->get('entry_icon_image');?> </td>';
		html += '		<td> ';
		html += '			<a href="" id="thumb-image'+banner_row+'" data-toggle="image" class="img-thumbnail">';
		html += '				<img src="<?php echo $no_image; ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" />';
		html += '			</a>';
		html += '			<input type="hidden" name="pavcategorybanner_module[image][]" value="" id="input-image'+banner_row+'" />';
		html += '		</td>'; 
		html += '		<td><?php echo $objlang->get('entry_addition_class');?></td>';
		html += '		<td><input class="form-control" type="text" name="pavcategorybanner_module[class][]"></td>';
		html += '		<td size="4"><a class="btn btn-danger btn-sm" onclick="$(\'#category-tab-wrapper'+index+'\').remove(); return false;"><i class="fa fa-minus-circle"></i></a></td>';   
		html += '	</tr>'
		html += '</table> ';
		$('#'+wrapper).append( html );
	}
</script>
<style type="text/css">
	.no-border > td{ border-top: 1px solid white !important;}
	.no-style{ width: 25%;}
</style>
<?php echo $footer; ?>