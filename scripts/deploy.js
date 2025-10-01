async function main() {
  const TrafficControl = await ethers.getContractFactory("TrafficControl");
  const contract = await TrafficControl.deploy();

  await contract.deployed();
  console.log("Contract deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
