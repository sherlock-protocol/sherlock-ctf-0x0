// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract CustomMarketplace is ERC721, ERC721URIStorage, ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter internal _tokenIds;

    uint256 internal constant MAX_ROYALTIES = 5_000;
    uint256 internal constant PERCENTAGE_SCALE = 10_000;

    mapping(uint256 => address) internal _tokenCreator;
    mapping(uint256 => uint256) internal _tokenCreatorRoyaltiesPerc;
    mapping(uint256 => address) internal _tokenCreatorRoyaltiesReceiver;
    mapping(uint256 => uint256) internal _tokenSalePrice;

    struct Offer {
        bool isForSale;
        uint256 tokenId;
        address seller;
        uint256 sellPrice;
    }

    mapping(uint256 => Offer) public nftsForSale;

    event NFTCreated(
        uint256 indexed tokenId,
        address indexed creator,
        string metadataURI,
        uint256 royaltiesPercent,
        uint256 salePrice
    );

    event NFTSold(
        uint256 indexed tokenId,
        address indexed oldOwner,
        address indexed newOwner,
        uint256 salePrice,
        uint256 priceToSeller,
        uint256 priceToCreator
    );

    constructor() ERC721("", "") {}

    function createNFTAndPutOnSale(
        string memory tokenMetaUri,
        uint256 royaltiesPercent,
        uint256 salePrice
    ) external returns (uint256 newTokenId) {
        require(
            royaltiesPercent <= MAX_ROYALTIES,
            "Royalties percentage exceeds max limit."
        );
        require(salePrice > 0, "Sale price 0.");

        _tokenIds.increment();

        newTokenId = _tokenIds.current();
        _safeMint(msg.sender, newTokenId, "");

        _tokenCreator[newTokenId] = msg.sender;

        _setTokenURI(newTokenId, tokenMetaUri);

        _tokenCreatorRoyaltiesPerc[newTokenId] = royaltiesPercent;
        _tokenCreatorRoyaltiesReceiver[newTokenId] = msg.sender;

        _tokenSalePrice[newTokenId] = salePrice;

        emit NFTCreated(
            newTokenId,
            msg.sender,
            tokenMetaUri,
            royaltiesPercent,
            salePrice
        );
    }

    function buyNFTFromSale(uint256 tokenId)
        external
        payable
        nonReentrant
        returns (bool)
    {
        uint256 salePrice = _tokenSalePrice[tokenId];
        require(msg.value >= salePrice, "Sale price > Sent value.");

        uint256 ownerAmount = salePrice;
        uint256 creatorAmount;
        address oldOwner = ownerOf(tokenId);
        address newOwner = msg.sender;

        address royaltiesReceiver = _tokenCreatorRoyaltiesReceiver[tokenId];
        uint256 royaltiesPerc = _tokenCreatorRoyaltiesPerc[tokenId];
        if (royaltiesPerc > 0) {
            creatorAmount = (salePrice * royaltiesPerc) / PERCENTAGE_SCALE;
            ownerAmount = ownerAmount - creatorAmount;
        }

        _transfer(oldOwner, newOwner, tokenId);

        (bool isSendToOldOwner, ) = payable(oldOwner).call{value: ownerAmount}(
            ""
        );
        require(isSendToOldOwner, "Send to owner fail.");

        if (creatorAmount > 0) {
            (bool isSendToCreator, ) = payable(royaltiesReceiver).call{
                value: creatorAmount
            }("");
            require(isSendToCreator, "Send to creator fail.");
        }

        if (msg.value - salePrice > 0) {
            (bool isSendToBuyer, ) = payable(msg.sender).call{
                value: creatorAmount
            }("");
            require(isSendToBuyer, "Refund to buyer fail.");
        }

        emit NFTSold(
            tokenId,
            oldOwner,
            newOwner,
            salePrice,
            ownerAmount,
            creatorAmount
        );

        return true;
    }

    function updateInfo(
        uint256 tokenId,
        address _newReceiver,
        uint256 _newRoyaltyPerc,
        uint256 _newSalePrice
    ) external {
        require(ownerOf(tokenId) == msg.sender, "Not owner.");
        require(_tokenSalePrice[tokenId] > 0, "Not on sale.");

        _tokenCreatorRoyaltiesReceiver[tokenId] = _newReceiver;
        _tokenCreatorRoyaltiesPerc[tokenId] = _newRoyaltyPerc;
        _tokenSalePrice[tokenId] = _newSalePrice;
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
