async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    // console.log("Account balance:", (await deployer.getBalance()).toString());
  
    const Token = await ethers.getContractFactory("CryptoBoys");
    const cryptoBoysToken = await Token.deploy();
    await cryptoBoysToken.deployed();
    console.log("CryptoBoys Token address:", cryptoBoysToken.address);

    const fs = require("fs");
    const contractsDir = __dirname + "/../src/abis";
    if (!fs.existsSync(contractsDir)) {
      fs.mkdirSync(contractsDir);
    }

    fs.writeFileSync(
      contractsDir + "/contract-address.json",
      JSON.stringify({ 
        CryptoBoysToken : cryptoBoysToken.address
      }, undefined, 2)
    );

    const CryptoBoysTokenArtifact = artifacts.readArtifactSync("CryptoBoys");
    fs.writeFileSync(
        contractsDir + "/CryptoBoys.json",
        JSON.stringify(CryptoBoysTokenArtifact, null, 2)
    );
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });