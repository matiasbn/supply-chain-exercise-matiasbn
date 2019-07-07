pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";
import "../contracts/Proxy.sol";

contract TestSupplyChain {

    // Test for failing conditions in this contracts:
    // https://truffleframework.com/tutorials/testing-for-throws-in-solidity-tests

    // enum State {
    //     ForSale,
    //     Sold,
    //     Shipped,
    //     Received
    // }

    // SupplyChain public chain;
    // Proxy public proxyseller;
    // Proxy public proxybuyer;

    // string itemName = "testItem";
    // uint256 itemPrice = 3 wei;
    // uint256 itemSku = 0;

    // allow contract to receive ether
    // function () external payable {}

    // function beforeEach() public {
    //     chain = new SupplyChain();
    //     proxyseller = new Proxy(chain);
    //     proxybuyer = new Proxy(chain);
    //     uint256 seedValue = itemPrice + 1 wei;
    //     address(proxyseller).transfer(seedValue);
    //     address(proxybuyer).transfer(seedValue);
    // }

    // buyItem
    // test for failure if user does not send enough funds
    // function testUserDoesNotSendEnoughFunds() public {
    //     // Add an item by the item seller
    //     bool itemAddedResult = proxyseller.placeItemForSale(itemName, itemPrice);
    //     Assert.isTrue(itemAddedResult, "placeItemForSale should return true");

    //     // // Try to buy but with less than amount. The sku is 0.
    //     // uint badPrice = itemPrice - 1;
    //     // SupplyChain(address(throwProxy)).buyItem(sku);
    //     // bool r = throwProxy.execute(badPrice);
    //     // Assert.isFalse(r, "Should be false, as it should throw");

    // }
    // test for purchasing an item that is not for Sale

    // function testPurchasingAnItemThatIsNotForSale() public {
    //     string memory itemName = "testItem";
    //     uint itemPrice = 10 wei;
    //     uint sku = 0;
    //     bool itemAddedResponse = chain.addItem(itemName,itemPrice);
    //     Assert.isTrue(itemAddedResponse, "Item is not successfully saved");

    //     // Buy the item
    //     chain.buyItem.value(itemPrice)(sku);

    //     // Should try to buy the same item again
    //     SupplyChain(address(throwProxy)).buyItem(sku);
    //     bool r = throwProxy.execute(itemPrice);
    //     Assert.isFalse(r, "Should be false, as it should throw");
    // }
    // shipItem

    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold

    // receiveItem

    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped

}