<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
*
* Classe Form_Model
*
* Gerencia camada de dados da biblioteca form.
* 
* @since		16/03/2013
* @location		acme.models.form_model
*
*/
class Form_Model extends CI_Model {
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
		$this->load->database();
	}
	
	/**
	* get_field_meta_data()
	* Retorna meta-dados de um campo de nome e tabela encaminhados.
	* @param int id_form
	* @param string table
	* @return array fields
	*/
	public function get_field_meta_data($table = '', $column_name = '')
	{
		$sql = "SELECT c.*,
					   fk.*,
      				   CASE WHEN (SELECT COUNT(*) 
         							FROM all_constraints cons 
   							  INNER JOIN all_cons_columns cols ON (cons.constraint_name = cols.constraint_name AND cols.owner = cons.owner) 
        						   WHERE cols.table_name = c.table_name 
           							 AND cols.column_name = c.column_name 
           							 AND cons.constraint_type = 'P'
      							 ) > 0 THEN 'PRI' END AS column_key,
      				   CASE WHEN c.nullable = 'N' THEN 'NO' ELSE 'YES' END AS IS_NULLABLE,
      				   ROWNUM AS ORDINAL_POSITION
				  FROM user_tab_cols c
			 LEFT JOIN (SELECT a.column_name, 
			 				   c_pk.table_name AS REFERENCED_TABLE_NAME, 
			 				   'FOREIGN KEY' AS CONSTRAINT_TYPE, 
			 				   a.TABLE_NAME
       					  FROM all_cons_columns a
  						  JOIN all_constraints    c ON (a.owner = c.owner AND a.constraint_name = c.constraint_name)
  						  JOIN all_constraints c_pk ON (c.r_owner = c_pk.owner AND c.r_constraint_name = c_pk.constraint_name)
 						 WHERE c.constraint_type = 'R'
 						   AND a.table_name = '" . strtoupper($table) . "'
 					   ) fk ON (fk.column_name = c.column_name AND fk.table_name = c.table_name)
				 WHERE c.table_name  = '" . strtoupper($table) . "'
  				   AND c.column_name = '" . strtoupper($column_name) . "'";
		$data = $this->db->query($sql);
		$data = $data->result_array();
		return (isset($data[0])) ? $data[0] : array();
	}
}
