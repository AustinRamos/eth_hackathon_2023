API_URL = "https://api-goerli.etherscan.io/api"
API_KEY = "P3NP2612RAEKHK4SCBTG8NU7F67HWQESQQ"
PRIVATE_KEY = ""
CONTRACT_ADDRESS = "0x6822Eaa36B2d1C68CDECa46450A84E67cFEC5c03"

const contract = require("../artifacts/contracts/AA/SmartWalletFactory.sol/SmartWalletFactory.json");


 console.log(JSON.stringify(contract.abi));


//  We will need to perform a number of steps in order:

//     Get the Factory contract interface to interact with
const contract = require("../artifacts/contracts/AA/SmartWallet.sol/SmartWallet.json");
//     Deploy a Greeter contract via the factory.
await Factory.CreateNewWallet('hello!')
//     Interact with newly created Greeter contract through the factory.