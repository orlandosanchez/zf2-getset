<?php
$scriptName   = array_shift($argv);
$className    = array_shift($argv);
echo '<?php';
?>

class <?=$className;?> {
<?php foreach($argv as $prop): ?>
  public $<?php echo $prop;?>;
<?php endforeach; ?>

  public function exchangeArray($data) {
<?php foreach($argv as $prop): ?>
    $this-><?php echo $prop;?> = ($data['<?php echo $prop;?>']) ? $data['<?php echo $prop;?>'] : NULL;
<?php endforeach; ?>
  }
       
<?php foreach($argv as $prop): 
    $methodName= implode('', array_map(function($token) {
      return ($token == 'id') ? strtoupper($token) : ucfirst($token);  
    }, explode('_', $prop)));?>
  public function get<?php echo $methodName;?>() {
    return $this-><?php echo $prop;?>;
  }
  public function set<?php echo $methodName;?>(<?php echo $prop;?>) {
    $this-><?php echo $prop;?> = <?echo $prop;?>;
  }

<?php endforeach; ?>
}
<?php echo '?>';
