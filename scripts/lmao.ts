import { ethers } from "hardhat";

async function main() {
 //Deploy Scripts
 //  const _name = "LMAO";
 //  const _symbol = "LMAO";
 //  //Random Address
 //  const _transferFeeAddr = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8";
 //  const tokenLMAO = await ethers.deployContract("LMAO", [
 //   _name,
 //   _symbol,
 //   _transferFeeAddr,
 //  ]);
 //  tokenLMAO.waitForDeployment();
 //  console.log(tokenLMAO);
 //  console.log(`TokenB deployed to ${tokenLMAO.target}`);

 const LMAOAddress = "0x1938110BB34B6eE2d062cfA28d4cBe3a05aE16f2";
 const LMAOContract = await ethers.getContractAt("LMAO", LMAOAddress);

 const [owner] = await ethers.getSigners();
 //  const signer = await ethers.getImpersonatedSigner(owner.address);

 //Lmao deployed to 0x1938110BB34B6eE2d062cfA28d4cBe3a05aE16f2
 const balance = await LMAOContract.balanceOf(owner.address);
 console.log(balance);
 const getBalance = await LMAOContract.getBalance();
 console.log(getBalance);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
 console.error(error);
 process.exitCode = 1;
});
