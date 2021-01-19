-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.16-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for realisticlifev2
CREATE DATABASE IF NOT EXISTS `realisticlifev2` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `realisticlifev2`;

-- Dumping structure for table realisticlifev2.apartments
CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.apartments: ~0 rows (approximately)
/*!40000 ALTER TABLE `apartments` DISABLE KEYS */;
/*!40000 ALTER TABLE `apartments` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.banks
CREATE TABLE IF NOT EXISTS `banks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `coords` longtext DEFAULT NULL,
  `cashiercoords` longtext DEFAULT NULL,
  `beforevaults` longtext DEFAULT NULL,
  `vaults` longtext DEFAULT NULL,
  `vaultgate` longtext DEFAULT NULL,
  `finalgate` longtext DEFAULT NULL,
  `vg_spots` longtext DEFAULT NULL,
  `m_spots` longtext DEFAULT NULL,
  `bankOpen` tinyint(1) NOT NULL DEFAULT 1,
  `bankCooldown` int(11) NOT NULL DEFAULT 0,
  `bankType` enum('Small','Big','Paleto') NOT NULL DEFAULT 'Small',
  `moneyBags` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.banks: ~8 rows (approximately)
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` (`id`, `name`, `coords`, `cashiercoords`, `beforevaults`, `vaults`, `vaultgate`, `finalgate`, `vg_spots`, `m_spots`, `bankOpen`, `bankCooldown`, `bankType`, `moneyBags`) VALUES
	(1, 'Fleeca', '{"x":149.88,"y":-1040.34,"z":29.37,"h":157.66}', '{"door":{"outside":{"x":145.26,"y":-1041.17,"z":29.37,"h":242.62},"coords":{"x":145.4186,"y":-1041.813,"z":29.64255}, "hash":-131754413, "oh":160.0 , "ch":249.846}, "counters":[{"x":146.87,"y":-1041.12,"z":29.37,"h":339.77},{"x":148.23,"y":-1041.62,"z":29.37,"h":345.57},{"x":149.66,"y":-1042.15,"z":29.37,"h":346.35},{"x":150.98,"y":-1042.62,"z":29.37,"h":332.29}]}', NULL, '{"door":{"thermite":{"spark":{"x":147.515,"y":-1044.41,"z":29.47},"drip":{"x":147.29,"y":-1045.41,"z":29.37},"bomb":{"offset":{"x":0.20,"y":-0.025,"z":0.15},"rotation":{"x":90.0,"y":-90.0,"z":0.0}},"heading":250.0},"coords":{"x":148.0266,"y":-1044.364,"z":29.50693}, "hash":2121050683, "oh": 160.0, "ch":249.846}, "coords":{"x":146.94,"y":-1046.14,"z":29.37,"h":247.43}}', '{"door":{"coords":{"x":150.2913,"y":-1047.629,"z":29.6663}, "hash":-1591004109, "oh": 90.0, "ch":159.478}, "coords":{"x":148.55,"y":-1046.29,"z":29.35,"h":162.25}}', NULL, '[{"x":151.18,"y":-1046.7,"z":29.35,"h":248.73},{"x":150.53,"y":-1045.16,"z":29.35,"h":340.25},{"x":149.03,"y":-1044.7,"z":29.35,"h":333.25}]', '[{"x":147.11,"y":-1047.69,"z":29.35,"h":77.05},{"x":146.6,"y":-1049.02,"z":29.35,"h":69.09},{"x":146.94,"y":-1050.24,"z":29.35,"h":160.26},{"x":149.21,"y":-1051.16,"z":29.35,"h":158.39},{"x":150.6,"y":-1049.09,"z":29.35,"h":253.12}]', 1, 0, 'Small', NULL),
	(2, 'Fleeca 2', '{"x":-350.83,"y":-49.6,"z":49.04,"h":156.65}', '{"door":{"outside":{"x":-355.5,"y":-50.52,"z":49.04,"h":250.89},"coords":{"x":-355.3892,"y":-51.06769,"z":49.31105}, "hash":-131754413, "oh":160.0 , "ch":249.846}, "counters":[{"x":-354.06,"y":-50.37,"z":49.04,"h":340.74},{"x":-352.64,"y":-50.92,"z":49.04,"h":342.21},{"x":-351.15,"y":-51.34,"z":49.04,"h":339.83},{"x":-349.83,"y":-51.82,"z":49.04,"h":332.06}]}', NULL, '{"door":{"thermite":{"spark":{"x":-353.235,"y":-53.645,"z":49.14},"drip":{"x":-353.41,"y":-54.53,"z":49.04},"bomb":{"rotation":{"x":90.0,"y":-90.0,"z":0.0},"offset":{"x":0.25,"y":-0.125,"z":0.15}},"heading":250.0},"coords":{"x":-352.7365,"y":-53.57248,"z":49.17543}, "hash":2121050683, "oh": 160.0, "ch":249.846}, "coords":{"x":-353.85,"y":-55.32,"z":49.04,"h":247.94}}', '{"door":{"coords":{"x":-350.4144,"y":-56.79705,"z":49.3348}, "hash":-1591004109, "oh": 90.0, "ch":159.478}, "coords":{"x":-352.16,"y":-55.5,"z":49.01,"h":155.42}}', NULL, '[{"x":-349.55,"y":-55.83,"z":49.01,"h":250.5},{"x":-350.3,"y":-54.37,"z":49.01,"h":335.7},{"x":-351.58,"y":-53.84,"z":49.01,"h":344.11}]', '[{"x":-353.56,"y":-56.99,"z":49.01,"h":71.28},{"x":-354.12,"y":-58.49,"z":49.01,"h":70.56},{"x":-353.35,"y":-59.59,"z":49.01,"h":159.66},{"x":-351.55,"y":-60.29,"z":49.01,"h":169.66},{"x":-350.17,"y":-59.12,"z":49.01,"h":252.22}]', 1, 0, 'Small', NULL),
	(3, 'Fleeca 3', '{"y":-278.46,"z":54.17,"h":161.96,"x":314.36}', '{"door":{"outside":{"y":-279.61,"z":54.16,"h":257.06,"x":309.62},"coords":{"x":309.74914550781,"y":-280.1796875,"z":54.439262390137}, "hash":-131754413, "oh":170.0 , "ch":249.86596679688}, "counters":[{"y":-279.47,"z":54.16,"h":336.19,"x":311.17},{"y":-280.04,"z":54.16,"h":335.54,"x":312.59},{"y":-280.57,"z":54.16,"h":348.41,"x":314.09},{"y":-281.04,"z":54.16,"h":346.89,"x":315.44}]}', NULL, '{"door":{"thermite":{"spark":{"x":311.85,"y":-282.7875,"z":54.26},"drip":{"x":311.6,"y":-283.75,"z":54.16},"bomb":{"rotation":{"x":-90.0,"y":-70.0,"z":0.0},"offset":{"x":0.2775,"y":-0.04525,"z":0.15}},"heading":250.8},"coords":{"x":312.35800170898,"y":-282.73013305664,"z":54.303646087646}, "hash":2121050683, "oh": 160.0, "ch":249.86596679688}, "coords":{"y":-284.47,"z":54.16,"h":238.11,"x":311.25}}', '{"door":{"coords":{"x":314.62387084961,"y":-285.99447631836,"z":54.463008880615}, "hash":-1591004109, "oh": 90.0, "ch":159.86486816406}, "coords":{"y":-284.65,"z":54.14,"h":156.52,"x":312.85}}', NULL, '[{"y":-282.92,"z":54.14,"h":332.43,"x":313.28},{"y":-283.55,"z":54.14,"h":342.97,"x":314.91},{"y":-285.06,"z":54.14,"h":269.63,"x":315.49}]', '[{"y":-286.9,"z":54.14,"h":65.4,"x":311.13},{"y":-288.78,"z":54.14,"h":161.69,"x":311.49},{"y":-289.41,"z":54.14,"h":161.05,"x":313.18},{"y":-288.29,"z":54.14,"h":250.12,"x":314.91}]', 1, 0, 'Small', NULL),
	(4, 'Fleeca 4', '{"y":-330.26,"z":37.79,"h":202.22,"x":-1212.98}', '{"door":{"outside":{"y":-334.43,"z":37.78,"h":297.06,"x":-1215.42},"coords":{"x":-1214.9053955078,"y":-334.72808837891,"z":38.055507659912}, "hash":-131754413, "oh":206.0 , "ch":296.86373901367}, "counters":[{"y":-333.21,"z":37.78,"h":20.72,"x":-1214.47},{"y":-332.53,"z":37.78,"h":27.31,"x":-1213.13},{"y":-331.85,"z":37.78,"h":23.82,"x":-1211.79},{"y":-331.23,"z":37.78,"h":29.4,"x":-1210.52}]}', NULL, '{"door":{"thermite":{"spark":{"x":-1210.84,"y":-334.672,"z":37.88},"drip":{"y":-335.82,"z":37.78,"h":292.56,"x":-1211.04},"bomb":{"rotation":{"x":-90.0,"y":-117.0,"z":0.0},"offset":{"x":0.2275,"y":0.18525,"z":0.15}},"heading":300.0},"coords":{"x":-1211.2609863281,"y":-334.55960083008,"z":37.919891357422}, "hash":2121050683, "oh": 206.0, "ch":296.86373901367}, "coords":{"y":-336.54,"z":37.78,"h":300.07,"x":-1210.74}}', '{"door":{"coords":{"x":-1207.3282470703,"y":-335.12893676758,"z":38.079254150391}, "hash":-1591004109, "oh": 116.0, "ch":206.86373901367}, "coords":{"y":-335.44,"z":37.76,"h":208.27,"x":-1209.54}}', NULL, '[{"y":-333.94,"z":37.76,"h":18.13,"x":-1210.35},{"y":-333.27,"z":37.76,"h":17.2,"x":-1208.9},{"y":-333.75,"z":37.76,"h":297.68,"x":-1207.46}]', '[{"y":-338.26,"z":37.76,"h":116.27,"x":-1209.09},{"y":-339.5,"z":37.76,"h":209.88,"x":-1207.77},{"y":-338.33,"z":37.76,"h":206.97,"x":-1205.55},{"y":-336.61,"z":37.76,"h":293.18,"x":-1205.48}]', 1, 0, 'Small', NULL),
	(5, 'Fleeca 5', '{"y":482.81,"z":15.7,"h":263.13,"x":-2963.45}', '{"door":{"outside":{"y":478.74,"z":15.7,"h":2.36,"x":-2960.71},"coords":{"x":-2960.1762695313,"y":479.0104675293,"z":15.971563339233}, "hash":-131754413, "oh":267.0 , "ch":357.54205322266}, "counters":[{"y":480.22,"z":15.7,"h":102.5,"x":-2961.21},{"y":481.59,"z":15.7,"h":80.38,"x":-2961.19},{"y":483.14,"z":15.7,"h":89.06,"x":-2961.07},{"y":484.51,"z":15.7,"h":89.16,"x":-2961.09}]}', NULL, '{"door":{"thermite":{"spark":{"x":-2957.353,"y":483.2,"z":15.75},"drip":{"y":481.9,"z":15.7,"h":292.56,"x":-2957.33},"bomb":{"rotation":{"x":-90.0,"y":-180.0,"z":0.0},"offset":{"x":-0.0495,"y":0.22525,"z":0.15}},"heading":355.0},"coords":{"x":-2958.5385742188,"y":482.27056884766,"z":15.83594417572}, "hash":-63539571, "oh": 267.0, "ch":357.54205322266}, "coords":{"y":481.7,"z":15.7,"h":4.28,"x":-2956.5}}', '{"door":{"coords":{"x":-2956.1162109375,"y":485.42059326172,"z":15.995308876038}, "hash":-1591004109, "oh": 197.0, "ch":267.54205322266}, "coords":{"y":483.33,"z":15.68,"h":273.76,"x":-2956.87}}', NULL, '[{"y":483.36,"z":15.68,"h":88.47,"x":-2958.6},{"y":485.0,"z":15.68,"h":84.28,"x":-2958.44},{"y":485.96,"z":15.68,"h":359.14,"x":-2957.34}]', '[{"y":482.38,"z":15.68,"h":177.51,"x":-2954.18},{"y":483.4,"z":15.68,"h":269.76,"x":-2952.52},{"y":485.46,"z":15.68,"h":265.06,"x":-2952.43},{"y":486.28,"z":15.68,"h":350.95,"x":-2954.08}]', 1, 0, 'Small', NULL),
	(6, 'Fleeca 6', '{"y":2706.07,"z":38.09,"h":3.7,"x":1175.15}', '{"door":{"outside":{"y":2708.92,"z":38.09,"h":93.29,"x":1179.26},"coords":{"x":1178.8695068359,"y":2709.3647460938,"z":38.362506866455}, "hash":-131754413, "oh":0.1 , "ch":90.0}, "counters":[{"y":2708.25,"z":38.09,"h":173.3,"x":1177.77},{"y":2708.23,"z":38.09,"h":181.91,"x":1176.23},{"y":2708.24,"z":38.09,"h":187.4,"x":1174.81},{"y":2708.21,"z":38.09,"h":183.0,"x":1173.38}]}', NULL, '{"door":{"thermite":{"spark":{"x":1175.66,"y":2713.025,"z":38.19},"drip":{"y":2712.09,"z":38.09,"h":92.71,"x":1175.86},"bomb":{"rotation":{"x":-90.0,"y":-270.0,"z":0.0},"offset":{"x":-0.2195,"y":-0.05925,"z":0.13}},"heading":90.0},"coords":{"x":1175.5421142578,"y":2710.861328125,"z":38.226890563965}, "hash":2121050683, "oh": 0.1, "ch":90.0}, "coords":{"y":2712.88,"z":38.09,"h":97.27,"x":1175.97}}', '{"door":{"coords":{"x":1172.2911376953,"y":2713.1462402344,"z":38.386253356934}, "hash":-1591004109, "oh": 289.0, "ch":359.0}, "coords":{"y":2712.49,"z":38.07,"h":2.81,"x":1174.41}}', NULL, '[{"y":2710.82,"z":38.07,"h":183.46,"x":1174.3},{"y":2710.73,"z":38.07,"h":186.75,"x":1172.99},{"y":2711.95,"z":38.07,"h":90.38,"x":1171.78}]', '[{"y":2715.16,"z":38.07,"h":271.11,"x":1175.2},{"y":2716.82,"z":38.07,"h":356.82,"x":1174.22}{"y":2716.82,"z":38.07,"h":356.82,"x":1174.22},{"y":2716.79,"z":38.07,"h":1.54,"x":1172.25},{"y":2715.23,"z":38.07,"h":99.02,"x":1171.22}]', 1, 0, 'Small', NULL),
	(9, 'Paleto', '{"x":-112.22,"h":314.95,"z":31.63,"y":6468.92}', '{"door":{"outside":{"y":6468.29,"z":31.63,"h":41.06,"x":-108.89},"reverse":1,"coords":{"x":-108.91468811035,"y":6469.1049804688,"z":31.910284042358}, "hash":-1184592117, "oh":325.0 , "ch":44.863204956055}, "counters":[{"y":6468.99,"z":31.63,"h":136.44,"x":-110.22},{"y":6470.04,"z":31.63,"h":134.15,"x":-111.27},{"y":6471.14,"z":31.63,"h":134.03,"x":-112.28},{"y":6472.25,"z":31.63,"h":132.97,"x":-113.35}]}', '{"door":{"coords":{"x":-104.60489654541,"y":6473.4438476563,"z":31.795324325562,"h":150.00003051758},"hash":-1185205679,"ch":45.0,"oh":150.00003051758},"coords":{"y":6471.9,"z":31.63,"h":40.24,"x":-105.54}}', '{"door":{"thermite":{"spark":{"x":-105.8085,"y":6473.49509,"z":31.80},"drip":{"y":6472.29,"z":31.63,"h":184.07,"x":-105.49},"bomb":{"rotation":{"x":-90.0,"y":-225.0,"z":0.0},"offset":{"x":-0.32795,"y":0.220195,"z": 0.175}},"heading":45.0},"reverse":1,"coords":{"x":-104.81363677979,"y":6473.646484375,"z":31.9547996521}, "hash":1622278560, "oh": 325.0, "ch":45.013021469116}, "coords":{"y":6472.36,"z":31.63,"h":37.87,"x":-105.43}}', '{"door":{"thermite":{"spark":{"x":-105.552,"y":6476.13,"z":31.95},"drip":{"y":6474.6,"z":31.63,"h":314.79,"x":-105.82},"bomb":{"rotation":{"x":-90.0,"y":-135.0,"z":0.0},"offset":{"x":0.26795,"y":0.5495,"z":0.36}},"heading":320.0},"coords":{"x":-106.47130584717,"y":6476.1577148438,"z":31.9547996521}, "hash":1309269072, "oh": 244.0, "ch":314.96466064453}, "coords":{"y":6474.72,"z":31.63,"h":316.34,"x":-105.76}}', NULL, '[{"y":6472.92,"z":31.63,"h":141.47,"x":-106.56},{"y":6474.14,"z":31.63,"h":133.41,"x":-107.76},{"y":6475.82,"z":31.63,"h":55.73,"x":-107.53}]', '[{"y":6475.52,"z":31.63,"h":225.83,"x":-102.89},{"y":6477.48,"z":31.68,"h":320.61,"x":-102.47},{"y":6478.97,"z":31.63,"h":316.32,"x":-103.95},{"y":6478.68,"z":31.63,"h":39.94,"x":-105.89}]', 1, 0, 'Paleto', '{"x":-113.32,"h":316.07,"z":31.63,"y":6469.96}'),
	(10, 'Pacific', '{"x":242.1,"y":224.44,"z":106.29,"h":336.9}', '{"door":{"thermite":{"spark":{"x":257.457,"y":221.105,"z":106.39},"drip":{"x":257.27,"y":219.8,"z":106.29},"bomb":{"rotation":{"x":90.0,"y":-20.0,"z":0.0},"offset":{"x":0.135,"y":0.385,"z":0.15}},"heading":339.0},"outside":{"x":256.79,"y":220.03,"z":106.29,"h":355.46},"coords":{"x":256.31155395508,"y":220.65785217285,"z":106.42955780029,"h":340.00003051758},"hash":-222270721,"ch":-19.999971389771,"oh":70.0},"coords":{"x":256.79,"y":220.03,"z":106.29,"h":355.46}}', '{"door":{"coords":{"x":262.19808959961,"y":222.51881408691,"z":106.42955780029,"h":256.77621459961},"hash":746855201,"ch":-110.22378540039,"oh":-20.0},"coords":{"x":261.95,"y":223.1,"z":106.28,"h":241.67}}', '{"door":{"coords":{"x":255.22825622559,"y":223.97601318359,"z":102.39321899414,"h":160.17094421387},"hash":961976194,"ch":160.17094421387,"oh":70.0},"coords":{"x":253.29,"y":228.46,"z":101.68,"h":65.44}}', '{"door":{"thermite":{"spark":{"x":252.99,"y":221.75,"z":101.78},"drip":{"x":253.0,"y":220.97,"z":101.68},"bomb":{"rotation":{"x":-90.0,"y":20.0,"z":0.0},"offset":{"x":-0.005,"y":-0.255,"z":0.15}},"heading":161.0},"coords":{"x":251.85757446289,"y":221.06549072266,"z":101.83240509033,"h":160.00001525879},"hash":-1508355822,"ch":160.00001525879,"oh":70.0},"coords":{"x":252.63,"y":221.29,"z":101.68,"h":156.96}}', '{"door":{"thermite":{"spark":{"x":261.65,"y":216.62,"z":101.78},"drip":{"x":261.4,"y":215.67,"z":101.68},"bomb":{"rotation":{"x":-90.0,"y":-70.0,"z": 0.0},"offset":{"x":0.25,"y":-0.0325,"z":0.15}},"heading":250.0},"reverse":-1,"coords":{"x":261.30041503906,"y":214.50514221191,"z":101.83240509033,"h":250.17224121094},"hash":-1508355822,"ch":-109.82776641846,"oh":170.0},"coords":{"x":261.12,"y":215.24,"z":101.68,"h":252.85},"coords":{"x":261.06,"y":215.22,"z":101.68,"h":247.37}}', '[{"x":258.16,"y":218.56,"z":101.68,"h":341.82},{"x":259.71,"y":218.03,"z":101.68,"h":359.39},{"x":261.44,"y":217.41,"z":101.68,"h":0.29},{"x":259.99,"y":213.48,"z":101.68,"h":159.81},{"x":258.27,"y":214.1,"z":101.68,"h":167.51},{"x":256.48,"y":214.76,"z":101.68,"h":169.49}]', '[{"x":263.19,"y":212.32,"z":101.68,"h":164.78},{"x":266.09,"y":213.42,"z":101.68,"h":275.82},{"x":264.66,"y":216.23,"z":101.68,"h":357.47}]', 1, 0, 'Big', NULL);
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.bank_accounts
CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `record_id` bigint(255) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(250) DEFAULT NULL,
  `buisness` varchar(50) DEFAULT NULL,
  `buisnessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `amount` bigint(255) NOT NULL DEFAULT 0,
  `account_type` enum('Current','Savings','Buisness','Gang') NOT NULL DEFAULT 'Current',
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `citizenid` (`citizenid`),
  KEY `buisness` (`buisness`),
  KEY `buisnessid` (`buisnessid`),
  KEY `gangid` (`gangid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.bank_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `bank_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_accounts` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.bank_statements
CREATE TABLE IF NOT EXISTS `bank_statements` (
  `record_id` bigint(255) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `buisness` varchar(50) DEFAULT NULL,
  `buisnessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `deposited` int(11) DEFAULT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `buisness` (`buisness`),
  KEY `buisnessid` (`buisnessid`),
  KEY `gangid` (`gangid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.bank_statements: ~0 rows (approximately)
/*!40000 ALTER TABLE `bank_statements` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_statements` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.bans: ~0 rows (approximately)
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.bbvehicles
CREATE TABLE IF NOT EXISTS `bbvehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(250) DEFAULT NULL,
  `plate` varchar(250) NOT NULL,
  `fakeplate` varchar(250) DEFAULT NULL,
  `model` varchar(250) NOT NULL,
  `props` longtext DEFAULT NULL,
  `stats` varchar(250) DEFAULT NULL,
  `state` varchar(250) DEFAULT NULL,
  `parking` longtext DEFAULT NULL,
  `parts` longtext DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.bbvehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `bbvehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `bbvehicles` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1111 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.bills: ~0 rows (approximately)
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.character_current
CREATE TABLE IF NOT EXISTS `character_current` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` longtext DEFAULT NULL,
  `model` longtext DEFAULT NULL,
  `drawables` longtext DEFAULT NULL,
  `props` longtext DEFAULT NULL,
  `drawtextures` longtext DEFAULT NULL,
  `proptextures` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.character_current: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_current` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_current` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.character_face
CREATE TABLE IF NOT EXISTS `character_face` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` longtext DEFAULT NULL,
  `hairColor` longtext DEFAULT NULL,
  `headBlend` longtext DEFAULT NULL,
  `headOverlay` longtext DEFAULT NULL,
  `headStructure` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.character_face: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_face` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_face` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.crypto
CREATE TABLE IF NOT EXISTS `crypto` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.crypto: ~0 rows (approximately)
/*!40000 ALTER TABLE `crypto` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.crypto_transactions
CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1173 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.crypto_transactions: ~0 rows (approximately)
/*!40000 ALTER TABLE `crypto_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto_transactions` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `name` varchar(250) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `time` mediumtext DEFAULT NULL,
  `createdby` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.dealers: ~0 rows (approximately)
/*!40000 ALTER TABLE `dealers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dealers` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.dpkeybinds
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.dpkeybinds: ~0 rows (approximately)
/*!40000 ALTER TABLE `dpkeybinds` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpkeybinds` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.emotesbinds
CREATE TABLE IF NOT EXISTS `emotesbinds` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `steam` longtext NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.emotesbinds: ~0 rows (approximately)
/*!40000 ALTER TABLE `emotesbinds` DISABLE KEYS */;
/*!40000 ALTER TABLE `emotesbinds` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET hebrew COLLATE hebrew_bin DEFAULT NULL,
  `jail` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9545 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.fine_types: ~101 rows (approximately)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT INTO `fine_types` (`id`, `label`, `jail`, `amount`, `category`) VALUES
	(1, '?©??????© ??????¨?? ???¦?????¨', 0, 200, 0),
	(2, '?????¦?? ???¦???¨?? ?? ?????§???× ??× ??¢???¨ ?????¦??????', 0, 50, 0),
	(3, '? ???????? ?¢? ???¦?? ???? ? ????? ?©? ?????????©', 0, 200, 0),
	(4, '???¨???? ?? ?????§???×', 0, 220, 0),
	(5, '? ???????? ?? ?????§???× ??????¥ ????????©', 0, 250, 0),
	(6, '????¨?? ????§?©???? ??????§', 0, 300, 0),
	(7, '???¨???? ?? ?????§???×', 0, 250, 0),
	(8, '??? ?????? ?? ?????§???×', 0, 300, 0),
	(9, '?¢?¦???¨?× ?¨???? ?? ?????§???×', 0, 300, 0),
	(10, '???©? ??©?×?£ ???¢????? ?¢? ???¨???? ???¨????', 0, 350, 0),
	(11, '???©? ??¢?¦???¨ ???×??¨???¨ ?¢?¦???¨', 0, 300, 0),
	(12, '???©? ??¢?¦???¨ ???¨??????¨ ??????', 0, 250, 0),
	(13, '???¦?????? ?? ?????§???×', 0, 300, 0),
	(14, '? ???????? ???¨???? ?? ?????§??', 0, 600, 0),
	(15, '? ???????? ??? ?¨???©?????', 0, 1500, 0),
	(16, '?????¢ ?????¨??', 4, 1600, 0),
	(17, '?¢???§?£ ??× ????????¨???× ??????×?¨?× ??10 ?§?"?©', 0, 150, 0),
	(18, '?¢???§?£ ??× ????????¨???× ??????×?¨?× ??15 ?§?"?©', 0, 225, 0),
	(19, '?¢???§?£ ??× ????????¨???× ??????×?¨?× ??30 ?§?"?©', 0, 300, 0),
	(20, '?¢???§?£ ??× ????????¨???× ??????×?¨?× ??50 ?§?"?©', 0, 500, 0),
	(21, '??????? ?????¨????× ???×? ???¢??', 0, 500, 0),
	(22, '? ???????? ???©???¨???×', 0, 1000, 0),
	(23, '? ???????? ?¨?©?? ???×', 3, 1200, 0),
	(24, '?¢?????? ???× ??????? ????¨?????', 0, 400, 1),
	(25, '?©???????© ????????? ???§???¨??', 8, 650, 1),
	(26, '?©???????© ????????? ??©????', 12, 800, 1),
	(27, '???¢????× ?¢?????? ?¦???????¨', 0, 300, 1),
	(28, '???¢????× ?©?????¨', 0, 500, 1),
	(29, '?????? ????????? ??????? ????¨??', 0, 300, 1),
	(30, '?????? ????????? ??????? ?¢?????? ?¦???????¨', 0, 350, 1),
	(31, '?????? ????????? ??????? ?©?????¨', 0, 400, 1),
	(32, '?????? ???????? ??????? ????¨??', 0, 600, 1),
	(33, '?????? ???????? ??????? ?¢?????? ?¦???????¨', 0, 700, 1),
	(34, '?????? ???????? ??????? ?©?????¨', 0, 800, 1),
	(35, '?©?????¨??? ?¦???????¨??', 0, 250, 1),
	(36, '???????? ??¦???????¨', 0, 750, 1),
	(37, '??×? ??????¢ ????????', 2, 700, 1),
	(38, '???????× ??????? ??©???? ???¨????', 0, 750, 1),
	(39, '? ????????? ???©?????×???×', 5, 2500, 1),
	(40, '???©?×?×?????× ???§?¨?????× ?¨?????? ?? ?????§?????', 2, 500, 1),
	(41, '???©?×?×?????× ??????¨???¥ ?? ?????§??', 3, 600, 1),
	(42, '???????¢?? ???¨?????© ?¦???????¨??', 0, 150, 1),
	(43, '???????¢?? ???¨?????© ???©??×??', 0, 300, 1),
	(44, '? ????????? ???¨?????? ??©?????¨', 10, 1500, 1),
	(45, '???¨?????? ???©???¨?× ???©?¨??', 14, 2500, 1),
	(46, '?©??????', 20, 2500, 1),
	(47, '???×???????× ??©?????¨', 17, 4000, 1),
	(48, '?????? ?¢? ?????? ????', 3, 2000, 1),
	(49, '???×? ???????× ???¢?¦?¨', 0, 800, 1),
	(50, '??????????? ?????× ????©????', 0, 2000, 1),
	(51, '????×???? ? ?©?§ ?§? ????????????× ???¢???¨', 5, 1000, 2),
	(52, '????×???? ? ?©?§ ?§???? ?? ????????????× ???¢???¨', 9, 1250, 2),
	(53, '?©??????© ??? ?©?§ ??? ?¨???©?????', 8, 1500, 2),
	(54, '???????§?× ? ?©?§ ????×?? ?????§??\r\n', 9, 1800, 2),
	(55, '???????§?× ????? ???¨???¦??', 0, 400, 2),
	(56, '??? ?????× ?¨????', 3, 1000, 2),
	(57, '??????? ?? ???????¨ ??????¨ ???? ?? ?????§??', 9, 1500, 2),
	(58, '???????§?× ??¨???????? ?? ??¢? ????????× ??????×?¨?×', 4, 1000, 2),
	(59, '???????§?× ????§????', 6, 1250, 2),
	(60, '???????§?× ?§?¨??????? ??×??????????', 10, 1500, 2),
	(61, '???????§?× ?§?¨??§', 10, 1500, 2),
	(62, '???????§?× ?§???§????', 10, 1500, 2),
	(63, '???????§?× ?????? ??????¨?? ????????¨', 14, 2000, 2),
	(64, '????????? ??????', 7, 2000, 2),
	(65, '?????¨ ????????', 15, 2500, 2),
	(66, '???¨???¦?? ??????×/?¨?????© ???¨????', 11, 1750, 3),
	(67, '?©???? ??? ???×', 10, 2000, 3),
	(68, '?©???? ??? ???× ???????????', 18, 3500, 3),
	(69, '?©???? ??©????× ??? ?§', 20, 3750, 3),
	(70, '???????¢?? ???×??? ?× ???????? ????????¨???×', 25, 4000, 3),
	(71, '?©???? ??? ?§', 22, 4000, 3),
	(72, '?©???? ??? ?§ ???????', 25, 4500, 3),
	(73, '?©???? ??? ?§ ???????', 40, 5000, 3),
	(74, '????? ???', 20, 1750, 3),
	(75, '? ????????? ???¨?????? ???????', 10, 2500, 3),
	(76, '???¨?????? ???????', 25, 5000, 3),
	(77, '???????§?× ?????¦??? ??? ???????', 15, 1300, 3),
	(78, '?????¨ ??? ?©?§', 30, 10000, 3),
	(79, '?©??????© ?§?¨?????? ??? ???????????¨', 2, 750, 3),
	(80, '?©??????© ?§?¨?????? ??? ??? ?©?§ ?§?¨', 7, 950, 3),
	(81, '?©??????© ?§?¨?????? ??? ??? ?©?§ ???', 10, 1800, 3),
	(82, '?©??????© ?§?¨?????? ??? ???¦?????? ??©???¨?×??', 14, 2750, 3),
	(83, '???????£ ???¨????? ????????', 0, 1000, 3),
	(84, '? ????????? ??????????', 3, 1500, 3),
	(85, '??????????', 6, 2000, 3),
	(86, '?×?§?????× ????¨??', 2, 1250, 3),
	(87, '?×?§?????× ?¢?????? ?¦???????¨', 4, 1500, 3),
	(88, '?×?§?????× ?©?????¨', 6, 2000, 3),
	(89, '???????????????', 15, 1750, 3),
	(90, '???? ??', 20, 4500, 3),
	(91, '?????????× ????¨??', 10, 1000, 3),
	(92, '?????????× ?¢?????? ?¦???????¨', 25, 1500, 3),
	(93, '?????????× ?©?????¨', 30, 2500, 3),
	(94, '?????¨???? ???? ???×', 6, 1250, 3),
	(95, '? ????????? ??¨?¦?? ????¨??', 7, 2500, 3),
	(96, '? ????????? ??¨?¦?? ?¢?????? ?¦???????¨', 10, 3000, 3),
	(97, '? ????????? ??¨?¦?? ?©?????¨', 12, 3500, 3),
	(98, '???¨?????? ??? ??????? ?? ?×???????', 13, 2000, 3),
	(99, '?¨?¦?? ????¨??', 15, 3500, 3),
	(100, '?¨?¦?? ?¢?????? ?¦???????¨', 20, 4500, 3),
	(101, '?¨?¦?? ?©?????¨', 25, 6000, 3);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.gangs
CREATE TABLE IF NOT EXISTS `gangs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `grades` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.gangs: ~0 rows (approximately)
/*!40000 ALTER TABLE `gangs` DISABLE KEYS */;
/*!40000 ALTER TABLE `gangs` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.gang_territoriums
CREATE TABLE IF NOT EXISTS `gang_territoriums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang` varchar(50) DEFAULT NULL,
  `points` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.gang_territoriums: ~0 rows (approximately)
/*!40000 ALTER TABLE `gang_territoriums` DISABLE KEYS */;
/*!40000 ALTER TABLE `gang_territoriums` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.gloveboxitems
CREATE TABLE IF NOT EXISTS `gloveboxitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `info` text DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.gloveboxitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `gloveboxitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `gloveboxitems` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.gloveboxitemsnew
CREATE TABLE IF NOT EXISTS `gloveboxitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.gloveboxitemsnew: ~0 rows (approximately)
/*!40000 ALTER TABLE `gloveboxitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `gloveboxitemsnew` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.houselocations
CREATE TABLE IF NOT EXISTS `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(2) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.houselocations: ~0 rows (approximately)
/*!40000 ALTER TABLE `houselocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `houselocations` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.house_plants
CREATE TABLE IF NOT EXISTS `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building` (`building`),
  KEY `plantid` (`plantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.house_plants: ~0 rows (approximately)
/*!40000 ALTER TABLE `house_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_plants` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `grades` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.lapraces: ~5 rows (approximately)
/*!40000 ALTER TABLE `lapraces` DISABLE KEYS */;
INSERT INTO `lapraces` (`id`, `name`, `checkpoints`, `records`, `creator`, `distance`, `raceid`) VALUES
	(1, 'Airport Track', '[{"offset":{"left":{"x":-991.5677490234375,"y":-2453.9521484375,"z":19.939929962158204},"right":{"x":-1008.70458984375,"y":-2443.69091796875,"z":18.922775268554689}},"coords":{"x":-1000.1361694335938,"y":-2448.821533203125,"z":19.431352615356447}},{"offset":{"left":{"x":-815.0484619140625,"y":-2472.11767578125,"z":13.345173835754395},"right":{"x":-799.7384033203125,"y":-2467.50048828125,"z":12.814240455627442}},"coords":{"x":-807.3934326171875,"y":-2469.80908203125,"z":13.079707145690918}},{"offset":{"left":{"x":-699.1527709960938,"y":-2132.7880859375,"z":12.696050643920899},"right":{"x":-689.7816772460938,"y":-2143.18896484375,"z":12.728630065917969}},"coords":{"x":-694.4672241210938,"y":-2137.988525390625,"z":12.712340354919434}},{"offset":{"left":{"x":-554.5692138671875,"y":-2076.084716796875,"z":26.789255142211915},"right":{"x":-556.4508056640625,"y":-2091.973876953125,"z":26.828920364379884}},"coords":{"x":-555.510009765625,"y":-2084.029296875,"z":26.8090877532959}},{"offset":{"left":{"x":-142.76153564453126,"y":-2072.63916015625,"z":25.43614387512207},"right":{"x":-132.3812255859375,"y":-2100.78515625,"z":25.214075088500978}},"coords":{"x":-137.57138061523438,"y":-2086.712158203125,"z":25.325109481811525}},{"offset":{"left":{"x":413.74725341796877,"y":-2118.468994140625,"z":18.581972122192384},"right":{"x":435.21514892578127,"y":-2139.424072265625,"z":18.451948165893556}},"coords":{"x":424.481201171875,"y":-2128.946533203125,"z":18.51696014404297}},{"offset":{"left":{"x":733.9149780273438,"y":-2047.303466796875,"z":28.648794174194337},"right":{"x":730.4972534179688,"y":-2077.108154296875,"z":28.706945419311525}},"coords":{"x":732.2061157226563,"y":-2062.205810546875,"z":28.67786979675293}},{"offset":{"left":{"x":1191.74267578125,"y":-2057.301513671875,"z":42.84389114379883},"right":{"x":1198.498779296875,"y":-2086.531005859375,"z":42.88191604614258}},"coords":{"x":1195.1207275390626,"y":-2071.916259765625,"z":42.8629035949707}},{"offset":{"left":{"x":1313.6610107421876,"y":-1606.9630126953126,"z":51.94519805908203},"right":{"x":1337.9532470703126,"y":-1589.3643798828126,"z":51.527610778808597}},"coords":{"x":1325.80712890625,"y":-1598.1636962890626,"z":51.73640441894531}},{"offset":{"left":{"x":1142.779296875,"y":-932.03564453125,"z":49.757774353027347},"right":{"x":1172.74658203125,"y":-932.4591064453125,"z":48.420127868652347}},"coords":{"x":1157.762939453125,"y":-932.2473754882813,"z":49.088951110839847}},{"offset":{"left":{"x":1199.4090576171876,"y":-354.2447204589844,"z":68.4808120727539},"right":{"x":1228.8988037109376,"y":-359.7543029785156,"z":68.48050689697266}},"coords":{"x":1214.1539306640626,"y":-356.99951171875,"z":68.48065948486328}},{"offset":{"left":{"x":777.529296875,"y":-60.16054153442383,"z":79.98756408691406},"right":{"x":792.2294921875,"y":-34.00894546508789,"z":79.99075317382813}},"coords":{"x":784.87939453125,"y":-47.08474349975586,"z":79.9891586303711}},{"offset":{"left":{"x":46.78907775878906,"y":239.84771728515626,"z":109.0110855102539},"right":{"x":57.794097900390628,"y":267.7562255859375,"z":108.94274139404297}},"coords":{"x":52.291587829589847,"y":253.80197143554688,"z":108.97691345214844}},{"offset":{"left":{"x":-666.2013549804688,"y":243.02239990234376,"z":80.75395965576172},"right":{"x":-679.1115112304688,"y":270.10198974609377,"z":80.90831756591797}},"coords":{"x":-672.6564331054688,"y":256.56219482421877,"z":80.83113861083985}},{"offset":{"left":{"x":-1395.973388671875,"y":171.14959716796876,"z":57.15483856201172},"right":{"x":-1416.78369140625,"y":192.75048828125,"z":57.73619842529297}},"coords":{"x":-1406.3785400390626,"y":181.95004272460938,"z":57.445518493652347}},{"offset":{"left":{"x":-1445.879150390625,"y":-105.63591003417969,"z":50.16816329956055},"right":{"x":-1465.54296875,"y":-82.97952270507813,"z":50.30636215209961}},"coords":{"x":-1455.7110595703126,"y":-94.3077163696289,"z":50.23726272583008}},{"offset":{"left":{"x":-1515.7847900390626,"y":-176.99298095703126,"z":53.54214859008789},"right":{"x":-1545.2510986328126,"y":-171.48504638671876,"z":54.72307205200195}},"coords":{"x":-1530.5179443359376,"y":-174.239013671875,"z":54.13261032104492}},{"offset":{"left":{"x":-1181.6107177734376,"y":-619.4964599609375,"z":23.709070205688478},"right":{"x":-1204.8563232421876,"y":-638.4605712890625,"z":23.680150985717775}},"coords":{"x":-1193.2335205078126,"y":-628.978515625,"z":23.694610595703126}},{"offset":{"left":{"x":-747.4027709960938,"y":-1125.5357666015626,"z":10.00879955291748},"right":{"x":-773.1150512695313,"y":-1140.9913330078126,"z":10.033381462097168}},"coords":{"x":-760.2589111328125,"y":-1133.2635498046876,"z":10.021090507507325}},{"offset":{"left":{"x":-640.74365234375,"y":-1489.7408447265626,"z":10.117782592773438},"right":{"x":-666.3165283203125,"y":-1485.0479736328126,"z":10.061010360717774}},"coords":{"x":-653.5300903320313,"y":-1487.3944091796876,"z":10.089396476745606}},{"offset":{"left":{"x":-754.353271484375,"y":-1788.722900390625,"z":28.22966957092285},"right":{"x":-770.0855712890625,"y":-1791.63720703125,"z":28.17951011657715}},"coords":{"x":-762.2194213867188,"y":-1790.1800537109376,"z":28.20458984375}},{"offset":{"left":{"x":-734.2152709960938,"y":-1869.4786376953126,"z":26.417682647705079},"right":{"x":-745.3294067382813,"y":-1874.0035400390626,"z":26.448028564453126}},"coords":{"x":-739.7723388671875,"y":-1871.7410888671876,"z":26.4328556060791}},{"offset":{"left":{"x":-697.6624145507813,"y":-2009.6754150390626,"z":24.706527709960939},"right":{"x":-709.5790405273438,"y":-2011.0699462890626,"z":24.926624298095704}},"coords":{"x":-703.6207275390625,"y":-2010.3726806640626,"z":24.81657600402832}},{"offset":{"left":{"x":-914.6879272460938,"y":-2323.271484375,"z":19.919706344604493},"right":{"x":-931.2211303710938,"y":-2312.05029296875,"z":19.059701919555665}},"coords":{"x":-922.9545288085938,"y":-2317.660888671875,"z":19.489704132080079}}]', '{"Time":8632,"Holder":["Letteral","Black"]}', 'NYO54967', 9916, 'LR-6640'),
	(2, 'Stadium Track', '[{"offset":{"left":{"z":27.599353790283204,"y":-1870.6998291015626,"x":-240.02561950683595},"right":{"z":28.810367584228517,"y":-1854.0782470703126,"x":-220.0692596435547}},"coords":{"z":28.20486068725586,"y":-1862.3890380859376,"x":-230.0474395751953}},{"offset":{"left":{"z":28.688560485839845,"y":-1685.899169921875,"x":-16.12961196899414},"right":{"z":28.684558868408204,"y":-1714.215576171875,"x":-6.221320629119873}},"coords":{"z":28.686559677124025,"y":-1700.057373046875,"x":-11.175466537475586}},{"offset":{"left":{"z":28.679059982299806,"y":-1492.6966552734376,"x":271.12896728515627},"right":{"z":28.697160720825197,"y":-1468.5948486328126,"x":288.992431640625}},"coords":{"z":28.6881103515625,"y":-1480.645751953125,"x":280.0606994628906}},{"offset":{"left":{"z":28.69242286682129,"y":-1325.06201171875,"x":63.4716911315918},"right":{"z":28.690187454223634,"y":-1310.75732421875,"x":89.84162139892578}},"coords":{"z":28.69130516052246,"y":-1317.90966796875,"x":76.65665435791016}},{"offset":{"left":{"z":29.04281997680664,"y":-1174.2862548828126,"x":38.26367950439453},"right":{"z":28.54150390625,"y":-1154.2950439453126,"x":37.94544219970703}},"coords":{"z":28.79216194152832,"y":-1164.2906494140626,"x":38.10456085205078}},{"offset":{"left":{"z":36.46794128417969,"y":-1210.0157470703126,"x":-294.7384033203125},"right":{"z":36.702049255371097,"y":-1192.0340576171876,"x":-293.96234130859377}},"coords":{"z":36.58499526977539,"y":-1201.02490234375,"x":-294.3503723144531}},{"offset":{"left":{"z":45.3591194152832,"y":-1255.5858154296876,"x":-438.085693359375},"right":{"z":45.004756927490237,"y":-1252.2904052734376,"x":-449.618896484375}},"coords":{"z":45.18193817138672,"y":-1253.9381103515626,"x":-443.852294921875}},{"offset":{"left":{"z":37.85808181762695,"y":-1551.4954833984376,"x":-440.9619445800781},"right":{"z":37.88176345825195,"y":-1547.2784423828126,"x":-452.1965026855469}},"coords":{"z":37.86992263793945,"y":-1549.386962890625,"x":-446.5792236328125}},{"offset":{"left":{"z":28.28677749633789,"y":-1682.914306640625,"x":-776.5343017578125},"right":{"z":28.47561264038086,"y":-1684.286865234375,"x":-746.5662841796875}},"coords":{"z":28.381195068359376,"y":-1683.6005859375,"x":-761.55029296875}},{"offset":{"left":{"z":10.65854263305664,"y":-1258.8736572265626,"x":-687.5741577148438},"right":{"z":9.704668045043946,"y":-1243.3814697265626,"x":-661.9016723632813}},"coords":{"z":10.181605339050293,"y":-1251.1275634765626,"x":-674.7379150390625}},{"offset":{"left":{"z":12.634703636169434,"y":-1029.1324462890626,"x":-836.4741821289063},"right":{"z":12.626439094543457,"y":-1015.3641357421875,"x":-844.6248168945313}},"coords":{"z":12.630571365356446,"y":-1022.248291015625,"x":-840.5494995117188}},{"offset":{"left":{"z":1.7506048679351807,"y":-1063.795166015625,"x":-901.4688110351563},"right":{"z":1.7662076950073243,"y":-1056.90673828125,"x":-905.5370483398438}},"coords":{"z":1.7584062814712525,"y":-1060.3509521484376,"x":-903.5029296875}},{"offset":{"left":{"z":1.4850856065750123,"y":-1102.9002685546876,"x":-966.9995727539063},"right":{"z":1.4405051469802857,"y":-1094.2799072265626,"x":-972.0678100585938}},"coords":{"z":1.462795376777649,"y":-1098.590087890625,"x":-969.53369140625}},{"offset":{"left":{"z":1.6013389825820923,"y":-1140.1158447265626,"x":-1027.162353515625},"right":{"z":1.398248314857483,"y":-1127.8226318359376,"x":-1033.8583984375}},"coords":{"z":1.4997936487197877,"y":-1133.96923828125,"x":-1030.5103759765626}},{"offset":{"left":{"z":7.127283573150635,"y":-1188.4119873046876,"x":-1225.47216796875},"right":{"z":7.103744029998779,"y":-1182.4359130859376,"x":-1196.073486328125}},"coords":{"z":7.115513801574707,"y":-1185.4239501953126,"x":-1210.7728271484376}},{"offset":{"left":{"z":6.168919563293457,"y":-1075.1533203125,"x":-1326.3895263671876},"right":{"z":6.573650360107422,"y":-1066.104736328125,"x":-1308.5579833984376}},"coords":{"z":6.3712849617004398,"y":-1070.6290283203126,"x":-1317.4737548828126}},{"offset":{"left":{"z":13.172541618347168,"y":-876.9158935546875,"x":-1387.8944091796876},"right":{"z":13.059271812438965,"y":-892.795654296875,"x":-1372.6688232421876}},"coords":{"z":13.115906715393067,"y":-884.8557739257813,"x":-1380.2816162109376}},{"offset":{"left":{"z":46.17762756347656,"y":-367.72265625,"x":-1750.99951171875},"right":{"z":45.71510314941406,"y":-341.74737548828127,"x":-1735.9970703125}},"coords":{"z":45.94636535644531,"y":-354.7350158691406,"x":-1743.498291015625}},{"offset":{"left":{"z":12.72506332397461,"y":-346.4041748046875,"x":-2123.230712890625},"right":{"z":12.630926132202149,"y":-368.8363037109375,"x":-2143.150146484375}},"coords":{"z":12.677994728088379,"y":-357.6202392578125,"x":-2133.1904296875}},{"offset":{"left":{"z":10.748030662536621,"y":-742.4968872070313,"x":-1597.380615234375},"right":{"z":10.820866584777832,"y":-763.7952270507813,"x":-1608.44287109375}},"coords":{"z":10.784448623657227,"y":-753.1460571289063,"x":-1602.9117431640626}},{"offset":{"left":{"z":11.00487995147705,"y":-650.4074096679688,"x":-1136.310546875},"right":{"z":10.926472663879395,"y":-673.3357543945313,"x":-1124.051513671875}},"coords":{"z":10.965676307678223,"y":-661.87158203125,"x":-1130.1810302734376}},{"offset":{"left":{"z":22.261215209960939,"y":-548.98828125,"x":-835.3270874023438},"right":{"z":22.49024200439453,"y":-562.7445068359375,"x":-832.7362670898438}},"coords":{"z":22.375728607177736,"y":-555.8663940429688,"x":-834.0316772460938}},{"offset":{"left":{"z":34.10263442993164,"y":-583.6516723632813,"x":-619.8589477539063},"right":{"z":34.29398727416992,"y":-585.8090209960938,"x":-649.7807006835938}},"coords":{"z":34.19831085205078,"y":-584.7303466796875,"x":-634.81982421875}},{"offset":{"left":{"z":31.290851593017579,"y":-643.3495483398438,"x":-596.4310913085938},"right":{"z":32.35036849975586,"y":-673.0432739257813,"x":-592.2881469726563}},"coords":{"z":31.82061004638672,"y":-658.1964111328125,"x":-594.359619140625}},{"offset":{"left":{"z":33.64102554321289,"y":-682.5008544921875,"x":-183.0003204345703},"right":{"z":33.65446853637695,"y":-695.454833984375,"x":-188.3102264404297}},"coords":{"z":33.64774703979492,"y":-688.9778442382813,"x":-185.6552734375}},{"offset":{"left":{"z":43.69054412841797,"y":-740.31298828125,"x":-52.22528076171875},"right":{"z":43.54344940185547,"y":-751.2342529296875,"x":-57.19569396972656}},"coords":{"z":43.61699676513672,"y":-745.7736206054688,"x":-54.710487365722659}},{"offset":{"left":{"z":43.51968765258789,"y":-775.2577514648438,"x":51.440311431884769},"right":{"z":43.5195198059082,"y":-786.5541381835938,"x":47.391658782958987}},"coords":{"z":43.51960372924805,"y":-780.9059448242188,"x":49.415985107421878}},{"offset":{"left":{"z":28.919464111328126,"y":-882.11572265625,"x":416.77203369140627},"right":{"z":28.680850982666017,"y":-881.6058349609375,"x":394.77923583984377}},"coords":{"z":28.80015754699707,"y":-881.8607788085938,"x":405.775634765625}},{"offset":{"left":{"z":28.952896118164064,"y":-1142.40771484375,"x":373.119384765625},"right":{"z":28.639862060546876,"y":-1120.4541015625,"x":374.5118408203125}},"coords":{"z":28.79637908935547,"y":-1131.430908203125,"x":373.81561279296877}},{"offset":{"left":{"z":28.65572166442871,"y":-1145.4266357421876,"x":229.2357177734375},"right":{"z":28.720849990844728,"y":-1148.2982177734376,"x":199.37353515625}},"coords":{"z":28.68828582763672,"y":-1146.8624267578126,"x":214.30462646484376}},{"offset":{"left":{"z":28.73360824584961,"y":-1496.63720703125,"x":88.40565490722656},"right":{"z":28.64876937866211,"y":-1478.88818359375,"x":64.2196044921875}},"coords":{"z":28.69118881225586,"y":-1487.7626953125,"x":76.31262969970703}},{"offset":{"left":{"z":29.007741928100587,"y":-1760.4581298828126,"x":-89.54359436035156},"right":{"z":28.819101333618165,"y":-1779.2552490234376,"x":-107.505615234375}},"coords":{"z":28.913421630859376,"y":-1769.856689453125,"x":-98.52460479736328}},{"offset":{"left":{"z":21.61324691772461,"y":-1879.126953125,"x":64.21072387695313},"right":{"z":21.88062286376953,"y":-1894.711181640625,"x":85.02079772949219}},"coords":{"z":21.74693489074707,"y":-1886.9190673828126,"x":74.61576080322266}},{"offset":{"left":{"z":28.471302032470704,"y":-1796.763671875,"x":191.82232666015626},"right":{"z":27.89031219482422,"y":-1806.9091796875,"x":182.19271850585938}},"coords":{"z":28.18080711364746,"y":-1801.83642578125,"x":187.0075225830078}},{"offset":{"left":{"z":25.790714263916017,"y":-1889.6351318359376,"x":245.68038940429688},"right":{"z":25.479145050048829,"y":-1877.2435302734376,"x":232.62844848632813}},"coords":{"z":25.634929656982423,"y":-1883.4393310546876,"x":239.1544189453125}},{"offset":{"left":{"z":24.674739837646486,"y":-1928.7872314453126,"x":-176.55191040039063},"right":{"z":23.693336486816408,"y":-1916.1019287109376,"x":-149.38348388671876}},"coords":{"z":24.184038162231447,"y":-1922.444580078125,"x":-162.9676971435547}}]', '{"Holder":["Mike","Oxlong"],"Time":12331}', 'NYO54967', 9447, 'LR-1332'),
	(3, 'Fast&Mud', '[{"offset":{"left":{"z":40.50144958496094,"y":-2611.23779296875,"x":1209.607666015625},"right":{"z":40.618019104003909,"y":-2597.18310546875,"x":1217.2529296875}},"coords":{"z":40.55973434448242,"y":-2604.21044921875,"x":1213.4302978515626}},{"offset":{"left":{"z":36.04168701171875,"y":-2591.954345703125,"x":1065.9268798828126},"right":{"z":35.388641357421878,"y":-2566.420654296875,"x":1061.0677490234376}},"coords":{"z":35.71516418457031,"y":-2579.1875,"x":1063.497314453125}},{"offset":{"left":{"z":29.486526489257814,"y":-1902.606689453125,"x":-935.9761962890625},"right":{"z":29.020645141601564,"y":-1899.46435546875,"x":-906.1448974609375}},"coords":{"z":29.253585815429689,"y":-1901.0355224609376,"x":-921.060546875}},{"offset":{"left":{"z":38.63145065307617,"y":-1601.4373779296876,"x":-450.17987060546877},"right":{"z":38.70289993286133,"y":-1611.8948974609376,"x":-433.13189697265627}},"coords":{"z":38.66717529296875,"y":-1606.6661376953126,"x":-441.6558837890625}},{"offset":{"left":{"z":36.5133056640625,"y":-1340.7301025390626,"x":-388.5645446777344},"right":{"z":36.52228546142578,"y":-1342.2225341796876,"x":-376.6576843261719}},"coords":{"z":36.51779556274414,"y":-1341.476318359375,"x":-382.6111145019531}},{"offset":{"left":{"z":36.63933181762695,"y":-1220.6229248046876,"x":-83.65338897705078},"right":{"z":36.64338302612305,"y":-1250.5904541015626,"x":-85.04769134521485}},"coords":{"z":36.641357421875,"y":-1235.606689453125,"x":-84.35054016113281}},{"offset":{"left":{"z":42.59724044799805,"y":-1201.584228515625,"x":683.5872802734375},"right":{"z":42.6904182434082,"y":-1231.509765625,"x":685.6990966796875}},"coords":{"z":42.643829345703128,"y":-1216.5469970703126,"x":684.6431884765625}},{"offset":{"left":{"z":44.98164749145508,"y":-1209.8048095703126,"x":814.384033203125},"right":{"z":44.990108489990237,"y":-1225.7720947265626,"x":815.4068603515625}},"coords":{"z":44.985877990722659,"y":-1217.7884521484376,"x":814.8954467773438}},{"offset":{"left":{"z":41.996002197265628,"y":-1219.679443359375,"x":965.7266235351563},"right":{"z":41.577476501464847,"y":-1233.40283203125,"x":957.5110473632813}},"coords":{"z":41.786739349365237,"y":-1226.5411376953126,"x":961.6188354492188}},{"offset":{"left":{"z":28.54838752746582,"y":-1620.2509765625,"x":1051.4677734375},"right":{"z":28.662485122680665,"y":-1621.85400390625,"x":1039.575927734375}},"coords":{"z":28.605436325073243,"y":-1621.052490234375,"x":1045.5218505859376}},{"offset":{"left":{"z":35.36176300048828,"y":-1772.0980224609376,"x":1087.20263671875},"right":{"z":35.16267395019531,"y":-1777.9656982421876,"x":1070.18701171875}},"coords":{"z":35.2622184753418,"y":-1775.0318603515626,"x":1078.69482421875}},{"offset":{"left":{"z":36.68062973022461,"y":-1847.1995849609376,"x":1121.8194580078126},"right":{"z":36.689327239990237,"y":-1867.6090087890626,"x":1130.0325927734376}},"coords":{"z":36.68497848510742,"y":-1857.404296875,"x":1125.926025390625}},{"offset":{"left":{"z":40.71408462524414,"y":-1798.8709716796876,"x":1251.43017578125},"right":{"z":40.184810638427737,"y":-1821.8883056640626,"x":1258.20654296875}},"coords":{"z":40.44944763183594,"y":-1810.379638671875,"x":1254.818359375}},{"offset":{"left":{"z":65.83296966552735,"y":-1755.8233642578126,"x":1386.93359375},"right":{"z":64.55730438232422,"y":-1779.2747802734376,"x":1391.873779296875}},"coords":{"z":65.19513702392578,"y":-1767.549072265625,"x":1389.4036865234376}},{"offset":{"left":{"z":65.34954833984375,"y":-1732.8062744140626,"x":1389.1021728515626},"right":{"z":65.50407409667969,"y":-1721.9320068359376,"x":1417.0616455078126}},"coords":{"z":65.42681121826172,"y":-1727.369140625,"x":1403.0819091796876}},{"offset":{"left":{"z":52.75725173950195,"y":-1572.8475341796876,"x":1360.0390625},"right":{"z":52.56576156616211,"y":-1593.6361083984376,"x":1375.653076171875}},"coords":{"z":52.66150665283203,"y":-1583.2418212890626,"x":1367.8460693359376}},{"offset":{"left":{"z":78.41255187988281,"y":-932.643310546875,"x":1926.4210205078126},"right":{"z":78.60076904296875,"y":-955.6204833984375,"x":1938.5870361328126}},"coords":{"z":78.50666046142578,"y":-944.1318969726563,"x":1932.5040283203126}},{"offset":{"left":{"z":79.53264617919922,"y":-960.3836669921875,"x":2012.7593994140626},"right":{"z":79.03247833251953,"y":-967.134765625,"x":1987.6561279296876}},"coords":{"z":79.28256225585938,"y":-963.7592163085938,"x":2000.207763671875}},{"offset":{"left":{"z":134.99781799316407,"y":-1402.228515625,"x":1891.9696044921876},"right":{"z":135.1073455810547,"y":-1392.098388671875,"x":1874.7252197265626}},"coords":{"z":135.05258178710938,"y":-1397.1634521484376,"x":1883.347412109375}},{"offset":{"left":{"z":123.32640838623047,"y":-1444.7716064453126,"x":1837.426513671875},"right":{"z":122.75972747802735,"y":-1429.3453369140626,"x":1828.168701171875}},"coords":{"z":123.0430679321289,"y":-1437.0584716796876,"x":1832.797607421875}},{"offset":{"left":{"z":117.7528305053711,"y":-1612.4935302734376,"x":1815.8134765625},"right":{"z":117.83548736572266,"y":-1618.7003173828126,"x":1798.917724609375}},"coords":{"z":117.79415893554688,"y":-1615.596923828125,"x":1807.3656005859376}},{"offset":{"left":{"z":106.26425170898438,"y":-2109.185546875,"x":1700.92431640625},"right":{"z":106.37551879882813,"y":-2100.30859375,"x":1687.613037109375}},"coords":{"z":106.31988525390625,"y":-2104.7470703125,"x":1694.2686767578126}},{"offset":{"left":{"z":93.6115493774414,"y":-2404.60546875,"x":1641.3350830078126},"right":{"z":93.58484649658203,"y":-2399.07275390625,"x":1624.2064208984376}},"coords":{"z":93.59819793701172,"y":-2401.839111328125,"x":1632.770751953125}},{"offset":{"left":{"z":47.66885757446289,"y":-2606.8955078125,"x":1445.59033203125},"right":{"z":47.64714431762695,"y":-2589.3681640625,"x":1449.6884765625}},"coords":{"z":47.65800094604492,"y":-2598.1318359375,"x":1447.639404296875}},{"offset":{"left":{"z":47.892215728759769,"y":-2589.394287109375,"x":1355.23583984375},"right":{"z":48.13071823120117,"y":-2573.955322265625,"x":1351.042724609375}},"coords":{"z":48.01146697998047,"y":-2581.6748046875,"x":1353.1392822265626}},{"offset":{"left":{"z":43.95314025878906,"y":-2613.38427734375,"x":1260.309326171875},"right":{"z":44.11415100097656,"y":-2599.76953125,"x":1257.051025390625}},"coords":{"z":44.03364562988281,"y":-2606.576904296875,"x":1258.68017578125}}]', '{"Holder":["Mike","Oxlong"],"Time":10318}', 'NYO54967', 8470, 'LR-2005'),
	(4, 'Grand Prix V1', '[{"offset":{"left":{"z":30.640655517578126,"y":6304.564453125,"x":-52.68119430541992},"right":{"z":30.65719223022461,"y":6322.7978515625,"x":-71.21620178222656}},"coords":{"z":30.648923873901368,"y":6313.68115234375,"x":-61.94869613647461}},{"offset":{"left":{"z":47.66134262084961,"y":4298.1171875,"x":-2204.864501953125},"right":{"z":47.46760177612305,"y":4315.576171875,"x":-2229.260009765625}},"coords":{"z":47.56447219848633,"y":4306.8466796875,"x":-2217.062255859375}},{"offset":{"left":{"z":16.23992919921875,"y":2966.866943359375,"x":-2595.217529296875},"right":{"z":15.806076049804688,"y":2973.845458984375,"x":-2620.260009765625}},"coords":{"z":16.02300262451172,"y":2970.356201171875,"x":-2607.73876953125}},{"offset":{"left":{"z":16.91878318786621,"y":2316.976318359375,"x":-2693.34228515625},"right":{"z":16.85959815979004,"y":2324.341552734375,"x":-2722.423828125}},"coords":{"z":16.889190673828126,"y":2320.658935546875,"x":-2707.883056640625}},{"offset":{"left":{"z":26.78049659729004,"y":2296.363037109375,"x":-2609.214599609375},"right":{"z":26.743440628051759,"y":2274.365478515625,"x":-2608.880126953125}},"coords":{"z":26.7619686126709,"y":2285.3642578125,"x":-2609.04736328125}},{"offset":{"left":{"z":33.862693786621097,"y":2390.2421875,"x":-1887.4979248046876},"right":{"z":33.81634521484375,"y":2368.80615234375,"x":-1882.5477294921876}},"coords":{"z":33.83951950073242,"y":2379.524169921875,"x":-1885.0228271484376}},{"offset":{"left":{"z":34.03313064575195,"y":2860.731689453125,"x":-555.8358154296875},"right":{"z":33.94906997680664,"y":2839.493408203125,"x":-561.5738525390625}},"coords":{"z":33.9911003112793,"y":2850.112548828125,"x":-558.704833984375}},{"offset":{"left":{"z":45.50830078125,"y":2899.302490234375,"x":-253.70826721191407},"right":{"z":45.40966796875,"y":2878.227294921875,"x":-260.0191345214844}},"coords":{"z":45.458984375,"y":2888.764892578125,"x":-256.86370849609377}},{"offset":{"left":{"z":56.42682647705078,"y":2808.122314453125,"x":-15.647430419921875},"right":{"z":56.49211883544922,"y":2786.351318359375,"x":-25.747879028320314}},"coords":{"z":56.45947265625,"y":2797.23681640625,"x":-20.697654724121095}},{"offset":{"left":{"z":44.02867126464844,"y":2647.124755859375,"x":291.6769104003906},"right":{"z":44.01610565185547,"y":2629.802978515625,"x":296.5713195800781}},"coords":{"z":44.02238845825195,"y":2638.4638671875,"x":294.1241149902344}},{"offset":{"left":{"z":45.20079803466797,"y":2995.23046875,"x":1988.2188720703126},"right":{"z":45.001190185546878,"y":2969.53759765625,"x":1992.1998291015626}},"coords":{"z":45.10099411010742,"y":2982.384033203125,"x":1990.2093505859376}},{"offset":{"left":{"z":47.750038146972659,"y":2983.83740234375,"x":2348.3720703125},"right":{"z":47.72065734863281,"y":2966.63232421875,"x":2338.1748046875}},"coords":{"z":47.735347747802737,"y":2975.23486328125,"x":2343.2734375}},{"offset":{"left":{"z":48.567569732666019,"y":2878.76513671875,"x":2444.093017578125},"right":{"z":48.44210433959961,"y":2867.9580078125,"x":2429.698974609375}},"coords":{"z":48.50483703613281,"y":2873.361572265625,"x":2436.89599609375}},{"offset":{"left":{"z":46.7886848449707,"y":2900.861328125,"x":2464.631103515625},"right":{"z":46.0306282043457,"y":2890.13671875,"x":2479.067138671875}},"coords":{"z":46.4096565246582,"y":2895.4990234375,"x":2471.84912109375}},{"offset":{"left":{"z":41.67623519897461,"y":3000.36181640625,"x":2543.15625},"right":{"z":41.75504684448242,"y":2993.654296875,"x":2553.1064453125}},"coords":{"z":41.715641021728519,"y":2997.008056640625,"x":2548.13134765625}},{"offset":{"left":{"z":54.96625900268555,"y":3434.3720703125,"x":2809.379638671875},"right":{"z":54.95486831665039,"y":3425.88134765625,"x":2829.675048828125}},"coords":{"z":54.96056365966797,"y":3430.126708984375,"x":2819.52734375}},{"offset":{"left":{"z":47.38029479980469,"y":4455.76220703125,"x":2785.3818359375},"right":{"z":47.358726501464847,"y":4462.02392578125,"x":2808.55029296875}},"coords":{"z":47.369510650634769,"y":4458.89306640625,"x":2796.966064453125}},{"offset":{"left":{"z":44.14406967163086,"y":5535.724609375,"x":2501.885498046875},"right":{"z":44.08613204956055,"y":5544.2705078125,"x":2524.312255859375}},"coords":{"z":44.1151008605957,"y":5539.99755859375,"x":2513.098876953125}},{"offset":{"left":{"z":20.476938247680665,"y":6452.83544921875,"x":1446.6458740234376},"right":{"z":20.446138381958009,"y":6481.15576171875,"x":1456.5435791015626}},"coords":{"z":20.461538314819337,"y":6466.99560546875,"x":1451.5947265625}},{"offset":{"left":{"z":30.603221893310548,"y":6388.46435546875,"x":30.556365966796876},"right":{"z":30.686019897460939,"y":6409.75732421875,"x":9.42294692993164}},"coords":{"z":30.644620895385743,"y":6399.11083984375,"x":19.989656448364259}}]', '{"Holder":["Mike","Oxlong"],"Time":14347}', 'NYO54967', 16040, 'LR-4311'),
	(5, 'Grand Prix V2', '[{"offset":{"left":{"z":30.645301818847658,"y":6204.91259765625,"x":-153.23202514648438},"right":{"z":30.424205780029298,"y":6227.43212890625,"x":-173.05209350585938}},"coords":{"z":30.534753799438478,"y":6216.17236328125,"x":-163.14205932617188}},{"offset":{"left":{"z":43.732242584228519,"y":5329.7080078125,"x":-1036.7596435546876},"right":{"z":43.0951042175293,"y":5352.6123046875,"x":-1049.0472412109376}},"coords":{"z":43.413673400878909,"y":5341.16015625,"x":-1042.9034423828126}},{"offset":{"left":{"z":56.864593505859378,"y":4482.7353515625,"x":-2020.3580322265626},"right":{"z":55.89692687988281,"y":4502.814453125,"x":-2033.4691162109376}},"coords":{"z":56.380760192871097,"y":4492.77490234375,"x":-2026.91357421875}},{"offset":{"left":{"z":16.318981170654298,"y":2346.2880859375,"x":-2686.2958984375},"right":{"z":16.222698211669923,"y":2353.63623046875,"x":-2715.3818359375}},"coords":{"z":16.27083969116211,"y":2349.962158203125,"x":-2700.8388671875}},{"offset":{"left":{"z":27.03206443786621,"y":2298.93115234375,"x":-2606.76220703125},"right":{"z":26.730653762817384,"y":2273.029296875,"x":-2609.00048828125}},"coords":{"z":26.881359100341798,"y":2285.980224609375,"x":-2607.88134765625}},{"offset":{"left":{"z":25.386920928955079,"y":2410.54345703125,"x":-1553.964599609375},"right":{"z":25.237045288085939,"y":2388.556640625,"x":-1553.215087890625}},"coords":{"z":25.311983108520509,"y":2399.550048828125,"x":-1553.58984375}},{"offset":{"left":{"z":33.993614196777347,"y":2861.314453125,"x":-555.3495483398438},"right":{"z":33.98682403564453,"y":2840.18115234375,"x":-561.4640502929688}},"coords":{"z":33.99021911621094,"y":2850.747802734375,"x":-558.4067993164063}},{"offset":{"left":{"z":57.45153045654297,"y":2779.068603515625,"x":34.64853286743164},"right":{"z":57.56243133544922,"y":2760.400634765625,"x":19.565645217895509}},"coords":{"z":57.506980895996097,"y":2769.734619140625,"x":27.107088088989259}},{"offset":{"left":{"z":40.0627555847168,"y":2710.3515625,"x":671.9955444335938},"right":{"z":40.06435775756836,"y":2690.6533203125,"x":668.5350952148438}},"coords":{"z":40.06355667114258,"y":2700.50244140625,"x":670.2653198242188}},{"offset":{"left":{"z":45.098106384277347,"y":2988.767822265625,"x":1970.969482421875},"right":{"z":45.131378173828128,"y":2970.918212890625,"x":1973.28955078125}},"coords":{"z":45.114742279052737,"y":2979.843017578125,"x":1972.1295166015626}},{"offset":{"left":{"z":44.67399597167969,"y":3008.216064453125,"x":2030.0487060546876},"right":{"z":44.5303955078125,"y":2999.080810546875,"x":2045.5577392578126}},"coords":{"z":44.602195739746097,"y":3003.6484375,"x":2037.80322265625}},{"offset":{"left":{"z":45.227169036865237,"y":3041.603759765625,"x":2045.5352783203126},"right":{"z":45.41890335083008,"y":3043.172119140625,"x":2063.4658203125}},"coords":{"z":45.323036193847659,"y":3042.387939453125,"x":2054.50048828125}},{"offset":{"left":{"z":46.530216217041019,"y":3085.27490234375,"x":2012.2235107421876},"right":{"z":46.305850982666019,"y":3105.40234375,"x":2025.2938232421876}},"coords":{"z":46.418033599853519,"y":3095.338623046875,"x":2018.7586669921876}},{"offset":{"left":{"z":35.98857879638672,"y":3490.038818359375,"x":1694.26220703125},"right":{"z":36.225181579589847,"y":3500.366943359375,"x":1713.685791015625}},"coords":{"z":36.10688018798828,"y":3495.202880859375,"x":1703.9739990234376}},{"offset":{"left":{"z":33.86867904663086,"y":3724.822265625,"x":1554.8046875},"right":{"z":33.822444915771487,"y":3737.9345703125,"x":1572.469970703125}},"coords":{"z":33.84556198120117,"y":3731.37841796875,"x":1563.6373291015626}},{"offset":{"left":{"z":34.25382995605469,"y":3791.593017578125,"x":1579.210693359375},"right":{"z":34.076995849609378,"y":3775.557373046875,"x":1591.16162109375}},"coords":{"z":34.16541290283203,"y":3783.5751953125,"x":1585.1861572265626}},{"offset":{"left":{"z":31.563051223754884,"y":3830.06396484375,"x":2013.421630859375},"right":{"z":31.716360092163087,"y":3821.50146484375,"x":1993.156982421875}},"coords":{"z":31.639705657958986,"y":3825.78271484375,"x":2003.289306640625}},{"offset":{"left":{"z":31.701337814331056,"y":3780.894775390625,"x":2042.0333251953126},"right":{"z":31.66097068786621,"y":3770.048095703125,"x":2020.6243896484376}},"coords":{"z":31.681154251098634,"y":3775.471435546875,"x":2031.328857421875}},{"offset":{"left":{"z":32.27469253540039,"y":3752.952880859375,"x":2092.541259765625},"right":{"z":32.44552993774414,"y":3732.143310546875,"x":2104.496826171875}},"coords":{"z":32.360111236572269,"y":3742.548095703125,"x":2098.51904296875}},{"offset":{"left":{"z":37.198341369628909,"y":4066.115478515625,"x":2469.0751953125},"right":{"z":37.005279541015628,"y":4056.885498046875,"x":2489.04443359375}},"coords":{"z":37.101810455322269,"y":4061.50048828125,"x":2479.059814453125}},{"offset":{"left":{"z":36.36289596557617,"y":4223.8681640625,"x":2439.560302734375},"right":{"z":36.41313552856445,"y":4230.1533203125,"x":2460.643310546875}},"coords":{"z":36.38801574707031,"y":4227.0107421875,"x":2450.101806640625}},{"offset":{"left":{"z":40.405704498291019,"y":4735.94677734375,"x":2187.987060546875},"right":{"z":40.32603073120117,"y":4757.46044921875,"x":2192.585693359375}},"coords":{"z":40.365867614746097,"y":4746.70361328125,"x":2190.286376953125}},{"offset":{"left":{"z":40.481727600097659,"y":4609.35546875,"x":2000.624755859375},"right":{"z":40.46068572998047,"y":4628.2587890625,"x":1989.369873046875}},"coords":{"z":40.47120666503906,"y":4618.80712890625,"x":1994.997314453125}},{"offset":{"left":{"z":41.28815841674805,"y":4810.2998046875,"x":1662.1715087890626},"right":{"z":41.45956039428711,"y":4812.9697265625,"x":1684.0081787109376}},"coords":{"z":41.37385940551758,"y":4811.634765625,"x":1673.08984375}},{"offset":{"left":{"z":43.095863342285159,"y":5154.76708984375,"x":1946.7135009765626},"right":{"z":43.301292419433597,"y":5139.48291015625,"x":1941.9842529296876}},"coords":{"z":43.198577880859378,"y":5147.125,"x":1944.348876953125}},{"offset":{"left":{"z":44.23796463012695,"y":5157.140625,"x":1982.1260986328126},"right":{"z":44.07059860229492,"y":5142.880859375,"x":1993.1099853515626}},"coords":{"z":44.15428161621094,"y":5150.0107421875,"x":1987.6180419921876}},{"offset":{"left":{"z":57.684814453125,"y":5234.28857421875,"x":2372.172119140625},"right":{"z":58.12598419189453,"y":5218.35498046875,"x":2363.810302734375}},"coords":{"z":57.905399322509769,"y":5226.32177734375,"x":2367.9912109375}},{"offset":{"left":{"z":43.78303909301758,"y":5102.37841796875,"x":2554.491943359375},"right":{"z":43.832820892333987,"y":5085.05517578125,"x":2559.380615234375}},"coords":{"z":43.80792999267578,"y":5093.716796875,"x":2556.936279296875}},{"offset":{"left":{"z":44.0772705078125,"y":5226.11279296875,"x":2599.610595703125},"right":{"z":44.052818298339847,"y":5235.04931640625,"x":2621.885009765625}},"coords":{"z":44.06504440307617,"y":5230.5810546875,"x":2610.747802734375}},{"offset":{"left":{"z":19.646240234375,"y":6460.0458984375,"x":1406.2740478515626},"right":{"z":19.633007049560548,"y":6489.28125,"x":1413.0047607421876}},"coords":{"z":19.639623641967775,"y":6474.66357421875,"x":1409.639404296875}},{"offset":{"left":{"z":31.085721969604493,"y":6526.1494140625,"x":178.7557830810547},"right":{"z":31.262479782104493,"y":6551.6982421875,"x":163.0315704345703}},"coords":{"z":31.174100875854493,"y":6538.923828125,"x":170.8936767578125}},{"offset":{"left":{"z":30.630319595336915,"y":6324.75341796875,"x":-30.463726043701173},"right":{"z":30.66328239440918,"y":6346.29150390625,"x":-51.34733200073242}},"coords":{"z":30.646800994873048,"y":6335.5224609375,"x":-40.9055290222168}}]', '{"Time":18064,"Holder":["Luis","Fernandez"]}', 'NYO54967', 17551, 'LR-7279');
/*!40000 ALTER TABLE `lapraces` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.mdt_reports
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `incident` longtext CHARACTER SET utf8 DEFAULT NULL,
  `charges` longtext CHARACTER SET utf8 DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.mdt_reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_reports` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.mdt_warrants
CREATE TABLE IF NOT EXISTS `mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `charges` longtext CHARACTER SET utf8 DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `expire` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `notes` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.mdt_warrants: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_warrants` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_warrants` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.moneysafes
CREATE TABLE IF NOT EXISTS `moneysafes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `safe` varchar(50) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT 0,
  `transactions` text NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.moneysafes: ~0 rows (approximately)
/*!40000 ALTER TABLE `moneysafes` DISABLE KEYS */;
/*!40000 ALTER TABLE `moneysafes` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.occasion_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `occasion_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `occasion_vehicles` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.permissions: ~3 rows (approximately)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `steam`, `license`, `permission`) VALUES
	(2, 'BM', 'steam:11000010447fe3e', 'license:028fe12dfd0748ee0b00d0ff158b344550f649f3', 'god'),
	(7, 'Twiztid', 'steam:110000107c9bc84', 'license:79d2afd169234c549d125d46d62bdecfabc4ea13', 'god'),
	(193, 'barbaronn', 'steam:11000011b7d8eda', 'license:d9cc83ceebdbca752f246b6ba6766d4c4bbacf63', 'god');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `invoiceid` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` varchar(50) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`invoiceid`) USING BTREE,
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.phone_invoices: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_invoices` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.phone_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.phone_tweets
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=5436 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.phone_tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_tweets` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.playerammo
CREATE TABLE IF NOT EXISTS `playerammo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `ammo` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=3638 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.playerammo: ~0 rows (approximately)
/*!40000 ALTER TABLE `playerammo` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerammo` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.playeritems
CREATE TABLE IF NOT EXISTS `playeritems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=255891 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.playeritems: ~0 rows (approximately)
/*!40000 ALTER TABLE `playeritems` DISABLE KEYS */;
/*!40000 ALTER TABLE `playeritems` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `steam` varchar(255) NOT NULL,
  `discord` varchar(255) DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `cards` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `citizenid` (`citizenid`),
  KEY `last_updated` (`last_updated`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.players: ~1 rows (approximately)
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` (`id`, `citizenid`, `cid`, `steam`, `discord`, `license`, `name`, `money`, `charinfo`, `cards`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`) VALUES
	(1, 'MVG84819', 1, 'steam:11000010c904b06', NULL, 'license:d07770705665d8389e170059eb1c68ea1a1782b0', 'Ryder', '{"bank":10009250,"crypto":0,"cash":9999026709}', '{"account":"RL07WL174","nationality":"british","phone":"0529103653","firstname":"test","card":6098205566406250,"birthdate":"1999-05-23","lastname":"test","backstory":"placeholder backstory","gender":0}', NULL, '{"onduty":true,"label":"Police","isboss":false,"name":"police","grade":{"level":3,"name":"Commander"},"payment":160}', '{"label":"Ballas Gang","name":"ballas"}', '{"x":214.6466064453125,"y":-816.6121215820313,"z":30.68613624572754,"a":116.76517486572266}', '{"isdead":false,"incarry":false,"jobrep":{"tow":0,"trucker":0,"hotdog":2,"taxi":0},"walk":"reset","phone":[],"inside":{"apartment":[]},"status":[],"callsign":"NO CALLSIGN","criminalrecord":{"date":{"sec":9,"year":2020,"hour":10,"isdst":false,"day":5,"min":21,"wday":7,"month":12,"yday":340},"hasRecord":true},"currentapartment":"apartment35475","hunger":24.399999999999957,"ishandcuffed":false,"stress":0,"inlaststand":false,"dealerrep":0,"walletid":"RL-68334960","thirst":31.600000000000049,"injail":0,"attachmentcraftingrep":0,"tracker":false,"bloodtype":"B+","fingerprint":"er778DfhR330737","craftingrep":0,"fitbit":[],"licences":{"driver":true,"business":false},"armor":0,"commandbinds":[],"jailitems":[]}', '[{"slot":1,"info":{"serie":"51Olh7mt405OSyW","ammo":1,"quality":76.20000000000232},"amount":1,"name":"weapon_microsmg","type":"weapon"},{"slot":2,"info":{"serie":"99kEY1Ln297aQot"},"amount":1,"name":"weapon_knife","type":"weapon"},{"slot":3,"info":{"serie":"50NzA2NP611Pnnz","ammo":0},"amount":1,"name":"weapon_stungun","type":"weapon"},{"slot":4,"info":[],"amount":1,"name":"cigar","type":"item"},{"slot":5,"info":[],"amount":1,"name":"fitbit","type":"item"},{"slot":6,"info":{"firstname":"test","lastname":"test","birthdate":"1999-05-23","nationality":"british","gender":0,"citizenid":"MVG84819"},"amount":1,"name":"id_card","type":"item"},{"slot":7,"info":[],"amount":1,"name":"lighter","type":"item"},{"slot":8,"info":[],"amount":1,"name":"assphone","type":"item"},{"slot":9,"info":{"serie":"34GLe1yS927OYlp"},"amount":1,"name":"weapon_smg","type":"weapon"},{"slot":10,"info":{"serie":"47OMo2EY327QbaG"},"amount":1,"name":"weapon_gusenberg","type":"weapon"},{"slot":11,"info":[],"amount":1,"name":"phone","type":"item"},{"slot":12,"info":{"serie":"88iWf6FC967oHln"},"amount":1,"name":"weapon_mg","type":"weapon"},{"slot":13,"info":[],"amount":1,"name":"tunerlaptop","type":"item"},{"slot":14,"info":[],"amount":1,"name":"Watch","type":"item"},{"slot":15,"info":{"cardPin":1111,"cardType":"mastercard","cardActive":true,"name":"test test","citizenid":"MVG84819","cardNumber":6098205566406250},"amount":1,"name":"mastercard","type":"item"},{"slot":16,"info":"","amount":1,"name":"hotdog","type":"item"},{"slot":17,"info":{"serie":"09nxp8pz712jvNG"},"amount":1,"name":"weapon_machinepistol","type":"weapon"},{"slot":18,"info":{"Amount":"1000","Author":{"cid":"MVG84819","name":"test test"},"Citizen":"ryder jones","Information":"wesrfwefdsf"},"amount":1,"name":"contract","type":"item"},{"slot":19,"info":[],"amount":1,"name":"weed_skunk","type":"item"},{"slot":20,"info":[],"amount":1,"name":"weed_skunk_seed","type":"item"},{"slot":21,"info":[],"amount":1,"name":"lockpick","type":"item"},{"slot":22,"info":{"firstname":"test","lastname":"test","type":"A1-A2-A | AM-B | C1-C-CE","birthdate":"1999-05-23"},"amount":1,"name":"driver_license","type":"item"},{"slot":23,"info":{"serie":"60Mhx6ir513HPYR"},"amount":1,"name":"weapon_assaultrifle","type":"weapon"}]', '2020-12-05 16:23:14');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.playerskins
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=45053 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.playerskins: ~0 rows (approximately)
/*!40000 ALTER TABLE `playerskins` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerskins` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.playerstattoos
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` longtext NOT NULL DEFAULT '0',
  `tattoos` longtext NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.playerstattoos: ~0 rows (approximately)
/*!40000 ALTER TABLE `playerstattoos` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerstattoos` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.player_boats
CREATE TABLE IF NOT EXISTS `player_boats` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `boathouse` varchar(50) DEFAULT NULL,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `state` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`#`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.player_boats: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_boats` DISABLE KEYS */;
INSERT INTO `player_boats` (`#`, `citizenid`, `model`, `plate`, `boathouse`, `fuel`, `state`) VALUES
	(16, 'EWF91799', 'dinghy', 'RL7179', NULL, 100, 0);
/*!40000 ALTER TABLE `player_boats` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.player_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_contacts` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.player_houses
CREATE TABLE IF NOT EXISTS `player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `house` (`house`),
  KEY `citizenid` (`citizenid`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.player_houses: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_houses` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.player_mails: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_mails` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_mails` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.player_outfits
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `skin` text DEFAULT NULL,
  `outfitId` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `outfitId` (`outfitId`)
) ENGINE=InnoDB AUTO_INCREMENT=9148 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.player_outfits: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_outfits` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.player_vehicles
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `insurance` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.player_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_vehicles` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.player_warns
CREATE TABLE IF NOT EXISTS `player_warns` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.player_warns: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_warns` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_warns` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.queue
CREATE TABLE IF NOT EXISTS `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table realisticlifev2.queue: ~0 rows (approximately)
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.stashitems
CREATE TABLE IF NOT EXISTS `stashitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15024 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.stashitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `stashitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `stashitems` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.stashitemsnew
CREATE TABLE IF NOT EXISTS `stashitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stash` (`stash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.stashitemsnew: ~0 rows (approximately)
/*!40000 ALTER TABLE `stashitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `stashitemsnew` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.trunkitems
CREATE TABLE IF NOT EXISTS `trunkitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=633 DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.trunkitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `trunkitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitems` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.trunkitemsnew
CREATE TABLE IF NOT EXISTS `trunkitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.trunkitemsnew: ~0 rows (approximately)
/*!40000 ALTER TABLE `trunkitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitemsnew` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.user_convictions
CREATE TABLE IF NOT EXISTS `user_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `offense` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.user_convictions: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_convictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_convictions` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.user_mdt
CREATE TABLE IF NOT EXISTS `user_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `notes` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `mugshot_url` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.user_mdt: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_mdt` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_mdt` ENABLE KEYS */;

-- Dumping structure for table realisticlifev2.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`steam`),
  UNIQUE KEY `identifier` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table realisticlifev2.whitelist: ~0 rows (approximately)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
