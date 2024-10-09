import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { ethers } from "hardhat";


const NomCoinModule = buildModule("NomCoin", (m) => {

  const initialSupply = ethers.parseEther('1000000');

  const nomCoin = m.contract("NomCoin",[initialSupply]);

  return { nomCoin };
});

export default NomCoinModule;
