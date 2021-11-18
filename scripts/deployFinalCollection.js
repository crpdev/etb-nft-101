
const { ethers } = require("hardhat");

async function main() {
  const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorldCollection");
  const superMarioWorld = await SuperMarioWorld.deploy("SuperMarioWorldCollection", "SPRMC", "https://ipfs.io/ipfs/Qmb6tWBDLd9j2oSnvSNhE314WFL7SRpQNtfwjFWsStXp5A/");
  await superMarioWorld.deployed();
  console.log("Success! Contract was deployed successfully at address: ", superMarioWorld.address); // Address: 0xA66d4427345762f1AdB4059a25aaa1B04E0549d5
  await superMarioWorld.mint(10);
  await superMarioWorld.mint(10);
  await superMarioWorld.mint(10);
  await superMarioWorld.mint(10);
  await superMarioWorld.mint(10);
  await superMarioWorld.mint(10);
  await superMarioWorld.mint(10);
  await superMarioWorld.mint(10);
  console.log("NFT successfully minted!");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
