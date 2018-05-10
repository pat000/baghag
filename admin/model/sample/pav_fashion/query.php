<?php 

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu' and `key` = 'pavmegamenu_module'";

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu_params' and `key` = 'params'";
$query['pavmegamenu'][] =  " 
INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES
(1234, 0, 'pavmegamenu_params', 'pavmegamenu_params', '[{\"id\":43,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":40,\"group\":0,\"cols\":1,\"subwidth\":1150,\"submenu\":1,\"align\":\"aligned-fullwidth\",\"rows\":[{\"cols\":[{\"widgets\":\"wid-38\",\"colwidth\":2},{\"widgets\":\"wid-42\",\"colwidth\":2},{\"widgets\":\"wid-43\",\"colwidth\":4},{\"widgets\":\"wid-44\",\"colwidth\":4}]}]},{\"id\":2,\"group\":0,\"cols\":3,\"subwidth\":350,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"widgets\":\"wid-49\",\"colwidth\":12}]}]},{\"id\":19,\"group\":0,\"cols\":1,\"submenu\":1,\"align\":\"aligned-left\",\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"submenu\":\"0\",\"id\":37,\"align\":\"aligned-left\",\"group\":0,\"cols\":1,\"rows\":[]}]', 0);
";

$query['pavverticalmenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavverticalmenu_params' and `key` = 'params'";
$query['pavverticalmenu'][] =" 
INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES
(344, 0, 'pavverticalmenu_params', 'params', '[{\"id\":2,\"group\":0,\"cols\":3,\"subwidth\":525,\"submenu\":1,\"rows\":[{\"cols\":[{\"widgets\":\"wid-22\",\"colwidth\":12}]},{\"cols\":[{\"widgets\":\"wid-23\",\"colwidth\":12}]}]},{\"submenu\":1,\"subwidth\":700,\"id\":5,\"cols\":2,\"group\":0,\"rows\":[{\"cols\":[{\"widgets\":\"wid-27\",\"colwidth\":\"3\"},{\"colwidth\":\"9\",\"widgets\":\"wid-29\"}]}]},{\"id\":3,\"group\":0,\"cols\":1,\"submenu\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":26,\"group\":0,\"cols\":1,\"submenu\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"id\":28,\"group\":0,\"cols\":1,\"submenu\":1,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]}]', 0);
";

$query['pavblog'][] ="
INSERT INTO `".DB_PREFIX ."layout_route` (`layout_route_id`, `layout_id`, `store_id`, `route`) VALUES
(0, 14, 0, 'pavblog/%');
";
$query['pavblog'][] ="
INSERT INTO `".DB_PREFIX ."layout` (`layout_id`, `name`) VALUES
(0, 'Pav Blog');
";
?>