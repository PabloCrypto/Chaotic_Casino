const Migrations = artifacts.require("./Migrations.sol");
	
	const bossAddress = "0x6092C95C5A946b496d465Bcb681b4C3654b93523";

module.exports = async function(deployer) {
 	deployer.deploy(Migrations);
};
