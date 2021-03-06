<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
*
* Classe Acme_Module_Manager_Model
*
* Gerencia camada de dados do módulo de administração de módulos do sistema.
* 
* @since		03/11/2012
* @location		acme.models.acme_module_manager_model
*
*/
class Acme_Module_Manager_Model extends Base_Module_Model {
	// Definição de Atributos
	
	/**
	* __construct()
	* Construtor de classe. Chama o construtor pai, que abre uma conexão com
	* o banco de dados, automaticamente.
	* @return object
	*/
	public function __construct()
	{
		parent::__construct();
	}
	
	/**
	* get_module_data()
	* Retorna dados de um determinado modulo com base no id encaminhado.
	* @param int id_module
	* @return array data
	*/
	public function get_module_data($id_module = 0)
	{
		$sql = "SELECT * FROM acm_module WHERE id_module = $id_module";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data[0])) ? $data[0] : array();
	}
	
	/**
	* get_list_modules()
	* Retorna um array de modulos cadastrados no sistema. Segundo parametro diz se é para
	* retornar modulos do acme ou não (chaveador entre modulos do acme e da aplicacao).
	* @param boolean show_acme_modules
	* @return array module
	*/
	public function get_list_modules($show_acme_modules = false)
	{
		$sql  = "SELECT * FROM acm_module ";
		$sql .= ($show_acme_modules) ? " WHERE controller LIKE '%acme_%' " : " WHERE controller NOT LIKE '%acme_%' ";
		$sql .= " ORDER BY lang_key_rotule";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data)) ? $data : array();
	}
	
	/**
	* get_form_data()
	* Retorna dados de um formulario específico de um id encaminhado.
	* @param int id_form
	* @return array form
	*/
	public function get_form_data($id_form = 0)
	{
		$sql = "SELECT * FROM acm_module_form WHERE id_module_form = $id_form";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data[0])) ? $data[0] : array();
	}
	
	/**
	* get_form_field_data()
	* Retorna dados de um campo de formulario específico de id encaminhado.
	* @param int id_form_field
	* @return array form
	*/
	public function get_form_field_data($id_form_field = 0)
	{
		$sql = "SELECT CASE WHEN f.dtt_inative IS NOT NULL THEN 'S' ELSE 'N' END AS form_inative,
					   f.operation,
					   f.id_module,
					   ff.*
				  FROM acm_module_form_field ff
			INNER JOIN acm_module_form        f ON (f.id_module_form = ff.id_module_form)
			     WHERE id_module_form_field = $id_form_field";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data[0])) ? $data[0] : array();
	}
	
	/**
	* get_config_form_data()
	* Retorna dados de um formulario específico de um modulo de id encaminhado. Para uso no bloco
	* de configurações de formulário
	* @param int id_module
	* @param string operation
	* @return array form
	*/
	public function get_config_form_data($id_module = 0, $operation = '')
	{
		$sql = "SELECT * FROM acm_module_form WHERE operation = '$operation' AND id_module = $id_module";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data[0])) ? $data[0] : array();
	}
	
	/**
	* get_config_form_field_data()
	* Retorna dados de um campo de formulario específico de id encaminhado. Para uso no bloco
	* de configurações de formulário.
	* @param string column_name
	* @param int id_form
	* @return array field
	*/
	public function get_config_form_field_data($column_name = '', $id_form = 0)
	{
		$sql = "SELECT * FROM acm_module_form_field WHERE table_column = '$column_name' AND id_module_form = $id_form";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data[0])) ? $data[0] : array();
	}
	
	/**
	* get_config_form_fields_data()
	* Retorna dados de campos de um formulario, com ligação dos campos de determinada tabela. Terceiro
	* parametro diz se é para montar consulta para filtros, que é um pouco diferente (não faz
	* ligação com tabela do modulo).
	* @param int id_form
	* @param string table
	* @param boolean is_filter
	* @return array fields
	*/
	public function get_config_form_fields_data($id_form = 0, $table = '', $is_filter = false)
	{
		if(!$is_filter)
		{
			$sql = "SELECT c.column_name,
					       CASE WHEN 
					       (SELECT COUNT(*) 
					          FROM all_constraints cons 
					    INNER JOIN all_cons_columns cols ON (cons.constraint_name = cols.constraint_name and cols.owner = cons.owner) 
					         WHERE cols.table_name = c.table_name 
					           AND cols.column_name = c.column_name 
					           AND cons.constraint_type = 'P'
					       ) > 0 THEN 'PRI' END AS column_key,
						   f.id_module_form_field,
						   f.lang_key_label as rotule,
						   f.type,
						   f.id_html,
						   f.order_,
						   CASE WHEN f.table_column IS NOT NULL AND f.dtt_inative IS NULL THEN 'checked=\"checked\"' ELSE '' END AS checked ,
						   rownum AS ordinal_position,
						   'N' AS column_not_exists,
						   f.*
					  FROM user_tab_cols c
				 LEFT JOIN acm_module_form_field f on (UPPER(f.table_column) = UPPER(c.column_name) AND f.id_module_form = $id_form)
					 WHERE UPPER(table_name) = '" . strtoupper($table) . "'

				  UNION
					
					/* CAMPOS QUE ESTÃO NO FORM MAS QUE NÃO ESTÃO NA TABELA */
					SELECT DISTINCT
						   f.table_column,
						   '',
						   f.id_module_form_field,
						   f.lang_key_label as rotule,
						   f.type,
						   f.id_html,
						   f.order_,
						   CASE WHEN f.table_column IS NOT NULL AND f.dtt_inative IS NULL THEN 'checked=\"checked\"' ELSE '' END AS checked ,
						   10000 AS ordinal_position,
						   'Y' AS column_not_exists,
						   f.*
					  FROM acm_module_form_field f
					 WHERE UPPER(f.table_column) NOT IN (SELECT UPPER(c.column_name) FROM user_tab_cols c WHERE c.table_name = '" . strtoupper($table) . "')
					   AND f.id_module_form = $id_form
					   
				  ORDER BY ordinal_position";
		} else {
			$sql = "SELECT DISTINCT
						   f.table_column as column_name,
						   '' as column_key,
						   f.id_module_form_field,
						   f.lang_key_label as rotule,
						   f.type,
						   f.id_html,
						   f.order_ AS ordinal_position,
						   CASE WHEN f.table_column IS NOT NULL AND f.dtt_inative IS NULL THEN 'checked=\"checked\"' ELSE '' END AS checked ,
						   'N' AS column_not_exists,
						   f.*
					  FROM acm_module_form_field f
					 WHERE f.id_module_form = $id_form
				  ORDER BY ordinal_position";
		}
		// DEBUG:
		// echo $sql;
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data)) ? $data : array();
	}
	
	/**
	* get_module_menu_insert()
	* Retorna dados de um menu que seja de formulario de inserção.
	* @param int id_module
	* @param string link
	* @return array field
	*/
	public function get_module_menu_insert($id_module = 0, $link = '')
	{
		$sql = "SELECT * FROM acm_module_menu WHERE id_module = $id_module AND link LIKE '%$link%'";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data[0])) ? $data[0] : array();
	}
	
	/**
	* get_module_action()
	* Retorna dados de uma ação de registro de módulo que seja de uma determinada operação.
	* @param int id_module
	* @param string link
	* @return array field
	*/
	public function get_module_action($id_module = 0, $link = '')
	{
		$sql = "SELECT * FROM acm_module_action WHERE id_module = $id_module AND link LIKE '%$link%'";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data[0])) ? $data[0] : array();
	}
	
	/**
	* get_module_permissions()
	* Retorna array de permissões de um módulo.
	* @param int id_module
	* @return array data
	*/
	public function get_module_permissions($id_module = 0)
	{
		$sql = "SELECT p.id_module_permission as \"#\",
					   p.lang_key_rotule as rotule,
					   p.permission as \"PERMISSION NAME\",
					   p.* 
				  FROM acm_module_permission p 
				 WHERE id_module = $id_module 
			  ORDER BY permission";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data)) ? $data : array();
	}
	
	/**
	* get_module_actions()
	* Retorna array de ações de registros de um módulo.
	* @param int id_module
	* @return array data
	*/
	public function get_module_actions($id_module = 0)
	{
		$sql = "SELECT a.id_module_action AS \"#\",
					   a.lang_key_rotule AS rotule,
					   a.url_img AS \"ICON\",
					   a.* 
				  FROM acm_module_action a 
				 WHERE id_module = $id_module 
			  ORDER BY order_, a.lang_key_rotule";;
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data)) ? $data : array();
	}
	
	/**
	* get_module_menus()
	* Retorna array de menus de um módulo.
	* @param int id_module
	* @return array data
	*/
	public function get_module_menus($id_module = 0)
	{
		$sql = "SELECT m.id_module_menu AS \"#\",
					   m.lang_key_rotule AS rotule,
					   m.* 
				  FROM acm_module_menu m
				 WHERE id_module = $id_module 
			  ORDER BY order_, m.lang_key_rotule";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data)) ? $data : array();
	}
}
