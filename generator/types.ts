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

export type CodeArtifacts = {
  [chain: string]: {
    code?: {
      imports?: string[];
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
