const contacts = artifacts.require("./Contacts.sol");

module.exports = function(deployer) {
  deployer.deploy(contacts);
};