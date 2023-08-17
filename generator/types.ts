export interface Options {
  force: boolean;
  chains: string[];
  protocolVersion: string;
  title: string;
  // automatically generated shortName from title
  shortName: string;
  author: string;
  discussion: string;
  snapshot: string;
  features: string[];
}

export enum DEPENDENCIES {
  Addresses,
  Assets,
  Engine,
}

export type CodeArtifacts = {
  [chain: string]: {
    code?: {
      dependencies?: DEPENDENCIES[];
      constants?: string[];
      fn?: string[];
      execute?: string[];
    };
    test?: {
      fn?: string[];
    };
  };
};

export interface FeatureModule<T extends {}> {
  cli: (opt: Options) => Promise<T>;
  build: (opt: Options, cfg: T) => CodeArtifacts;
}

export const ENGINE_FLAGS = {
  KEEP_CURRENT: 'KEEP_CURRENT',
} as const;

export const AVAILABLE_VERSIONS = {V2: 'V2', V3: 'V3'} as const;
