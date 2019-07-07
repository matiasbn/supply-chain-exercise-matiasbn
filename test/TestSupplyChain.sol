pragma solidity ^ 0.5 .0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";
import "../contracts/Proxy.sol";

contract TestSupplyChain {

    // Test for failing conditions in this contracts:
    // https://truffleframework.com/tutorials/testing-for-throws-in-solidity-tests

    uint public initialBalance = 1 ether;

    enum State {
        ForSale,
        Sold,
        Shipped,
        Received
    }

    SupplyChain public chain;
    Proxy public proxyseller;
    Proxy public proxybuyer;
    Proxy public proxyrandom;

    string itemName = "testItem";
    uint256 itemPrice = 3;
    uint256 itemSku = 0;

    // allow contract to receive ether
    function () external payable {}

    function beforeEach() public {
        chain = new SupplyChain();
        proxyseller = new Proxy(chain);
        proxybuyer = new Proxy(chain);
        proxyrandom = new Proxy(chain);
        uint256 seedValue = itemPrice + 1;
        address(proxyseller).transfer(seedValue);
        address(proxybuyer).transfer(seedValue);
    }

    // buyItem
    // test for failure if user does not send enough funds
    function testForFailureIfUserDoesNotSendEnoughFunds() public {
        // Add an item by the item seller
        bool itemAddedResult = proxyseller.placeItemForSale(itemName, itemPrice);
        Assert.isTrue(itemAddedResult, "placeItemForSale should return true");

        // Try to buy but with less than amount. The sku is 0.
        uint badPrice = itemPrice - 1;
        bool purchaseItemResult = proxybuyer.purchaseItem(itemSku, badPrice);
        Assert.isFalse(purchaseItemResult, "Should not be capable of buying");
    }

    // test for purchasing an item that is not for Sale
    function testPurchasingAnItemThatIsNotForSale() public {
        // Add an item by the item seller
        bool itemAddedResult = proxyseller.placeItemForSale(itemName, itemPrice);
        Assert.isTrue(itemAddedResult, "placeItemForSale should return true");

        // Try to buy it with correct amount
        uint correctPrice = itemPrice;
        bool purchaseItemResult = proxybuyer.purchaseItem(itemSku, correctPrice);
        Assert.isTrue(purchaseItemResult, "Should be capable of buying");

        // Try to buy the same item again
        purchaseItemResult = proxybuyer.purchaseItem(itemSku, correctPrice);
        Assert.isFalse(purchaseItemResult, "Should not be capable of buying the same item");
    }

    // shipItem

    // test for calls that are made by not the seller
    function testForCallsThatAreMadeByNotTheSeller() public {

        // Try to ship from the proxybuyer
        bool itemShippedResult = proxybuyer.shipItem(itemSku);
        Assert.isFalse(itemShippedResult, "shipItem should fail");
    }

    // test for trying to ship an item that is not marked Sold
    function testForTryingToShipAnItemThatIsNotMarkedSold() public {
        // Add an item by the item seller
        bool itemAddedResult = proxyseller.placeItemForSale(itemName, itemPrice);
        Assert.isTrue(itemAddedResult, "placeItemForSale should return true");
        
        // Try to ship from the proxyseller before it is selled
        bool itemShippedResult = proxyseller.shipItem(itemSku);
        Assert.isFalse(itemShippedResult, "shipItem should fail");
    }

    // receiveItem

    // test calling the function from an address that is not the buyer
    function testCallingReceiveItemFromAnAddressThatIsNotTheBuyer() public {
        // Add an item by the item seller
        bool itemAddedResult = proxyseller.placeItemForSale(itemName, itemPrice);
        Assert.isTrue(itemAddedResult, "placeItemForSale should return true");
        
        // Try to buy it with correct amount
        uint correctPrice = itemPrice;
        bool purchaseItemResult = proxybuyer.purchaseItem(itemSku, correctPrice);
        Assert.isTrue(purchaseItemResult, "Should be capable of buying");

        // Try to ship from the proxyseller
        bool itemShippedResult = proxyseller.shipItem(itemSku);
        Assert.isTrue(itemShippedResult, "shipItem should fail");

        // Try to receive it from random proxy
        bool itemReceivedResult = proxyrandom.receiveItem(itemSku);
        Assert.isFalse(itemReceivedResult, "shipItem should fail");   
    }
    // test calling the function on an item not marked Shipped
    function testCallingReceiveItemOnAnItemNotMarkedShipped() public {
        // Add an item by the item seller
        bool itemAddedResult = proxyseller.placeItemForSale(itemName, itemPrice);
        Assert.isTrue(itemAddedResult, "placeItemForSale should return true");
        
        // Try to buy it with correct amount
        uint correctPrice = itemPrice;
        bool purchaseItemResult = proxybuyer.purchaseItem(itemSku, correctPrice);
        Assert.isTrue(purchaseItemResult, "Should be capable of buying");

        // Try to receive it from buyerproxy before it is shipped
        bool itemReceivedResult = proxybuyer.receiveItem(itemSku);
        Assert.isFalse(itemReceivedResult, "shipItem should fail");   
    }

}