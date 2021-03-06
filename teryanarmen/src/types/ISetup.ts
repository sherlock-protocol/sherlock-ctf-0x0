/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  BaseContract,
  BigNumber,
  BytesLike,
  CallOverrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";
import { FunctionFragment, Result, EventFragment } from "@ethersproject/abi";
import { Listener, Provider } from "@ethersproject/providers";
import { TypedEventFilter, TypedEvent, TypedListener, OnEvent } from "./common";

export interface ISetupInterface extends utils.Interface {
  contractName: "ISetup";
  functions: {
    "isSolved()": FunctionFragment;
  };

  encodeFunctionData(functionFragment: "isSolved", values?: undefined): string;

  decodeFunctionResult(functionFragment: "isSolved", data: BytesLike): Result;

  events: {
    "Deployed(address)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "Deployed"): EventFragment;
}

export type DeployedEvent = TypedEvent<[string], { instance: string }>;

export type DeployedEventFilter = TypedEventFilter<DeployedEvent>;

export interface ISetup extends BaseContract {
  contractName: "ISetup";
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: ISetupInterface;

  queryFilter<TEvent extends TypedEvent>(
    event: TypedEventFilter<TEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TEvent>>;

  listeners<TEvent extends TypedEvent>(
    eventFilter?: TypedEventFilter<TEvent>
  ): Array<TypedListener<TEvent>>;
  listeners(eventName?: string): Array<Listener>;
  removeAllListeners<TEvent extends TypedEvent>(
    eventFilter: TypedEventFilter<TEvent>
  ): this;
  removeAllListeners(eventName?: string): this;
  off: OnEvent<this>;
  on: OnEvent<this>;
  once: OnEvent<this>;
  removeListener: OnEvent<this>;

  functions: {
    isSolved(overrides?: CallOverrides): Promise<[boolean]>;
  };

  isSolved(overrides?: CallOverrides): Promise<boolean>;

  callStatic: {
    isSolved(overrides?: CallOverrides): Promise<boolean>;
  };

  filters: {
    "Deployed(address)"(instance?: null): DeployedEventFilter;
    Deployed(instance?: null): DeployedEventFilter;
  };

  estimateGas: {
    isSolved(overrides?: CallOverrides): Promise<BigNumber>;
  };

  populateTransaction: {
    isSolved(overrides?: CallOverrides): Promise<PopulatedTransaction>;
  };
}
