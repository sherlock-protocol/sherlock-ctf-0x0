/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Signer,
  utils,
  Contract,
  ContractFactory,
  PayableOverrides,
} from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { Challenge2, Challenge2Interface } from "../Challenge2";

const _abi = [
  {
    inputs: [],
    stateMutability: "payable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "first",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "fourth",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "second",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "state",
    outputs: [
      {
        internalType: "enum Challenge2.State",
        name: "",
        type: "uint8",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "third",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "winner",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];

const _bytecode =
  "0x6080604052670de0b6b3a76400003414610081576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260058152602001807f636865617000000000000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b610afb806100906000396000f3fe608060405234801561001057600080fd5b50600436106100625760003560e01c80633df4ddf4146100675780635a8ac02d146100715780638c09138f1461007b578063a6dc677114610085578063c19d93fb1461008f578063dfbf53ae146100b8575b600080fd5b61006f6100ec565b005b610079610269565b005b610083610560565b005b61008d61087c565b005b610097610a7b565b604051808260038111156100a757fe5b815260200191505060405180910390f35b6100c0610a8c565b604051808273ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b6100f533610ab2565b15610168576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260088152602001807f796561682c206e6f00000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b600080600381111561017657fe5b60008054906101000a900460ff16600381111561018f57fe5b14610202576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260058152602001807f6e6f2e2e2e00000000000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b33600060016101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555060016000806101000a81548160ff0219169083600381111561026157fe5b021790555050565b600060019054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161461032c576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260048152602001807f6f6f70730000000000000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b61033533610ab2565b6103a7576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260098152602001807f74727920616761696e000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b60018060038111156103b557fe5b60008054906101000a900460ff1660038111156103ce57fe5b14610441576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260058152602001807f6e6f2e2e2e00000000000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b6105393373ffffffffffffffffffffffffffffffffffffffff166364d4d7006040518163ffffffff1660e01b8152600401602060405180830381600087803b15801561048c57600080fd5b505af11580156104a0573d6000803e3d6000fd5b505050506040513d60208110156104b657600080fd5b81019080805190602001909291905050501461053a576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260088152602001807f6e6f74206c65657400000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b60026000806101000a81548160ff0219169083600381111561055857fe5b021790555050565b600060019054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614610623576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260048152602001807f6f6f70730000000000000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b61062c33610ab2565b61069e576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260098152602001807f74727920616761696e000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b60038060038111156106ac57fe5b60008054906101000a900460ff1660038111156106c557fe5b14610738576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260058152602001807f6e6f2e2e2e00000000000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b620138d53373ffffffffffffffffffffffffffffffffffffffff166364d4d7006040518163ffffffff1660e01b8152600401602060405180830381600087803b15801561078457600080fd5b505af1158015610798573d6000803e3d6000fd5b505050506040513d60208110156107ae57600080fd5b810190808051906020019092919050505014610832576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260098152602001807f6e6f7420626f6f6273000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b3373ffffffffffffffffffffffffffffffffffffffff166108fc479081150290604051600060405180830381858888f19350505050158015610878573d6000803e3d6000fd5b5050565b600060019054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161461093f576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260048152602001807f6f6f70730000000000000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b61094833610ab2565b156109bb576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260088152602001807f796561682c206e6f00000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b60028060038111156109c957fe5b60008054906101000a900460ff1660038111156109e257fe5b14610a55576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260058152602001807f6e6f2e2e2e00000000000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b60036000806101000a81548160ff02191690836003811115610a7357fe5b021790555050565b60008054906101000a900460ff1681565b600060019054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600080823b90506000811191505091905056fea264697066735822122021bbb9909dd0b6b09fa9e99bf10724746fb3d2eea7f7b78aa8b1b79b66edc39a64736f6c63430007060033";

type Challenge2ConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: Challenge2ConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Challenge2__factory extends ContractFactory {
  constructor(...args: Challenge2ConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
    this.contractName = "Challenge2";
  }

  deploy(
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<Challenge2> {
    return super.deploy(overrides || {}) as Promise<Challenge2>;
  }
  getDeployTransaction(
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  attach(address: string): Challenge2 {
    return super.attach(address) as Challenge2;
  }
  connect(signer: Signer): Challenge2__factory {
    return super.connect(signer) as Challenge2__factory;
  }
  static readonly contractName: "Challenge2";
  public readonly contractName: "Challenge2";
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): Challenge2Interface {
    return new utils.Interface(_abi) as Challenge2Interface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): Challenge2 {
    return new Contract(address, _abi, signerOrProvider) as Challenge2;
  }
}
