import { ethers } from "hardhat";

async function main() {
 //Deploy Scripts

 //  const _name = "WLMAO";
 //  const _symbol = "WLMAO";
 //  const _transferFeeAddr = "0x8A91F5D0FaC39AB37c4E281a498eb68eA24ae078";
 //  const tokenWLMAO = await ethers.deployContract("WLMAO", [
 //   _transferFeeAddr,
 //   _name,
 //   _symbol,
 //  ]);
 //  tokenWLMAO.waitForDeployment();
 //  console.log(tokenWLMAO);
 //  console.log(`TokenB deployed to ${tokenWLMAO.target}`);

 const _amount = ethers.parseEther("1");
 //LMAO deployed to 0x5FbDB2315678afecb367f032d93F642f64180aa3
 const LMAOAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
 const WLMAOAddress = "0xd018dC9d291B386440cC46FC65929188CacCbf35";

 //  LMAO contract
 const LMAOContract = await ethers.getContractAt("LMAO", LMAOAddress);
 const WLMAOContract = await ethers.getContractAt("WLMAO", WLMAOAddress);
 const approveTokens = await LMAOContract.approve(WLMAOAddress, _amount);
 await approveTokens.wait();
 console.log(approveTokens);
 const deposit = await WLMAOContract.depositLmao(_amount);
 await deposit.wait();
 console.log(deposit);
 const withdraw = await WLMAOContract.withdrawLmao(_amount);
 await withdraw.wait();
 console.log(withdraw);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
 console.error(error);
 process.exitCode = 1;
});
