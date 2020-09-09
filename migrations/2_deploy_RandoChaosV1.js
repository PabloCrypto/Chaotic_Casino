const RandoChaosV1 = artifacts.require("RandoChaosV1");

	//mainnet directions
	const UniswapFactoryAddress = "0xc0a47dFe034B400B47bDaD5FecDa2621de6c4d95"; //mainnet Uniswap factory address
	const KyberNetworkProxyAddress = "0x818E6FECD516Ecc3849DAf6845e3EC868087B755"; //mainnet Kyber Network address

	const ethAddress = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE";
	const daiAddress = "0x6b175474e89094c44da98b954eedeac495271d0f";
	const wBtcAddress = "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599";


	//Ropsten testnet directions
	const UniswapFactoryAddressRopsten = "0x9c83dCE8CA20E9aAF9D3efc003b2ea62aBC08351";
	const KyberNetworkProxyAddressRopsten = "0x818E6FECD516Ecc3849DAf6845e3EC868087B755";

	const daiAddressRopsten = "0xaD6D458402F60fD3Bd25163575031ACDce07538D";//"0xf80A32A835F79D7787E8a8ee5721D0fEaFd78108"; //0xc2118d4d90b274016cb7a54c03ef52e6c537d957
	const daiAddressRopstenAave = "0xf80A32A835F79D7787E8a8ee5721D0fEaFd78108";

	const wBtcAddressRopsten =  "0x3dff0dce5fc4b367ec91d31de3837cf3840c8284";//"0xa0E54Ab6AA5f0bf1D62EC3526436F3c05b3348A0";
	const ethAddressRopsten = "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";

	const manaAddressRopsten =  "0x72fd6C7C1397040A66F33C2ecC83A0F71Ee46D5c";
	const kncAddressRopsten = "0x7b2810576aa1cce68f2b118cef1f36467c648f92";

	//Kovan testnet directions
	const UniswapFactoryAddressKovan = "0xD3E51Ef092B2845f10401a0159B2B96e8B6c3D30";
	const KyberNetworkProxyAddressKovan = "0x692f391bCc85cefCe8C237C01e1f636BbD70EA4D";


	const daiAddressKovan = "0x4f96fe3b7a6cf9725f59d353f723c1bdb64ca6aa";
	const kncAddressKovan = "0xad67cB4d63C9da94AcA37fDF2761AaDF780ff4a2";//"";0xd287c0d288c5466fe4734bc6ac977d5200ccb1df
	const manaAddressKovan = "0xcb78b457c1F79a06091EAe744aA81dc75Ecb1183";



module.exports = async function(deployer) {

  deployer.deploy(RandoChaosV1, daiAddressKovan);

};


