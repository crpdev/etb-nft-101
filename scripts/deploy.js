
const { ethers } = require("hardhat");

async function main() {
  // ERC721
  // const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorldOZ");
  // const superMarioWorld = await SuperMarioWorld.deploy("SuperMarioWorldOZ", "SPRMO");
  // await superMarioWorld.deployed();
  // console.log("Success! Contract was deployed successfully at address: ", superMarioWorld.address); // Address: 0x9bEE9395fAC2Fa673C52f6572E4D3aD00c0baC81
  // await superMarioWorld.mint("https://ipfs.io/ipfs/QmYoVjXNGbAVHKucFJ3xw8MMxWqFXHtyWPLzf4EB8aLW4f");
  // console.log("NFT successfully minted!");

  // ERC1155
  const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorldERC1155");
  const superMarioWorld = await SuperMarioWorld.deploy("SuperMarioWorldERC1155", "SPRME");
  await superMarioWorld.deployed();
  console.log("Success! Contract was deployed successfully at address: ", superMarioWorld.address); // Address: 0x7a9a6D7dBa0704d74Fb1c1b6325D468416E2b2ef
  await superMarioWorld.mint(10, "https://ipfs.io/ipfs/QmUYMgqe6AQVaw2UjYJ2NdAEdRnSB2k6VdMnHjhQ1swvMG");
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
