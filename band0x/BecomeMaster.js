const { parseEther } = require("ethers/lib/utils");

const main = async () => {
    
    const setupFactory = await hre.ethers.getContractFactory("Setup");
    const setupContract = await setupFactory.deploy({ value: parseEther("0.001") });
    await setupContract.deployed();
    console.log("Setup addy:", setupContract.address);
    console.log("Challenge Instance,", await setupContract.instance());
    

    const EXPLOIT = await ethers.getContractFactory("Exploit");

    const ctf = await ethers.getContractAt(
        "Exploit",
        await setupContract.instance()
      );
    
      console.log("solved:", await setupContract.isSolved());
    
      await EXPLOIT.deploy(ctf.address, { value: parseEther("0.001") });
    
      console.log("solved:", await setupContract.isSolved());
      

  };
  


  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();
