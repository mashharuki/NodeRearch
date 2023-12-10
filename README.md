# NodeRearch
Ethereum Nodeについて研究するためのリポジトリです。


## Dockerで動かす場合

```bash
docker stop ethereum/client-go
docker pull ethereum/client-go:latest
docker run -it -p 30303:30303 ethereum/client-go
```

## Docker Composeを使う場合

作業用のディレクトリを作成

```bash
export GETH_DATADIR=/data/geth
sudo mkdir -p $GETH_DATADIR
```
起動

```bash
cd  docker-compose/sepolia && docker-compose up -d
```

以下のようなコマンドが出てくればOK!

```bash
[+] Running 6/6
 ✔ genesis 1 layers [⣿]      0B/0B      Pulled                                                                                                                                                                                                                                                  2.1s 
   ✔ 661ff4d9561e Pull complete                                                                                                                                                                                                                                                                 0.6s 
 ✔ geth 3 layers [⣿⣿⣿]      0B/0B      Pulled                                                                                                                                                                                                                                                   3.0s 
   ✔ 96526aa774ef Pull complete                                                                                                                                                                                                                                                                 0.3s 
   ✔ 4f401217f33d Pull complete                                                                                                                                                                                                                                                                 0.3s 
   ✔ 7804efcedfd9 Pull complete                                                                                                                                                                                                                                                                 0.6s 
[+] Building 0.0s (0/0)                                                                                                                                                                                                                                                               docker:default
[+] Running 3/3
 ✔ Network sepolia_default      Created                                                                                                                                                                                                                                                         0.1s 
 ✔ Container sepolia-geth-1     Started                                                                                                                                                                                                                                                         0.0s 
 ✔ Container sepolia-genesis-1  Started   
```

下記コマンドでもチェック可能

```bash
docker-compose ls
```

```bash
NAME                STATUS              CONFIG FILES
sepolia             running(1)          /workspace/NodeRearch/docker-compose/sepolia/docker-compose.yml
```

下記コマンドでコンテナIDを指定

```bash
docker ps
```

```bash
CONTAINER ID   IMAGE                        COMMAND                  CREATED         STATUS                   PORTS                                                                                                                                                         NAMES
c473a79ff875   ethereum/client-go:v1.13.5   "geth --sepolia --da…"   4 minutes ago   Up 4 minutes (healthy)   0.0.0.0:8545-8546->8545-8546/tcp, :::8545-8546->8545-8546/tcp, 0.0.0.0:30303->30303/tcp, :::30303->30303/tcp, 0.0.0.0:30303->30303/udp, :::30303->30303/udp   sepolia-geth-1
```

下記コマンドでコンテナに入る

```bash
docker exec -it c473a79ff875 sh
```

## Gethの操作コマンド系

まず以下ディレクトリに移動する。

```bash
cd data
```

次に以下コマンドを打つ

```bash
geth attach geth.ipc
```

以下のようになればOK!

```bash
Welcome to the Geth JavaScript console!

instance: Geth/v1.13.5-stable-916d6a44/linux-amd64/go1.21.4
at block: 0 (Sun Oct 03 2021 13:24:41 GMT+0000 (UTC))
 datadir: /data
 modules: admin:1.0 debug:1.0 engine:1.0 eth:1.0 miner:1.0 net:1.0 rpc:1.0 txpool:1.0 web3:1.0

To exit, press ctrl-d or type exit
> 
```

アカウント確認

```bash
eth.accounts
```

アカウント作成

```bash
eth.newAccount("test01") 
```

諸々確認

```bash
> eth.accounts 
[]
> eth.newaccounts
undefined
> eth.accounts
[]
> eth.mining 
false
> net.listening 
true
> net.peerCount   
9
>  admin.peers 
[{
    caps: ["eth/68"],
    enode: "enode://7eee9275fbaf26ab272063c1c395c72a03f3ea1eb0dd35fe68d3feb0a2654bdfcc5539ece9974c782e943988f27d88c47eeb3c3a7987507f19e59e34b855a502@44.203.38.138:30303",
    id: "0383eb66eb3a95e9cf6afbad5357c26b66ba9d1ce4561980ab2a2bd72e38dc85",
    name: "erigon/v2.53.4-c4843268/linux-arm64/go1.20.8",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:53994",
      remoteAddress: "44.203.38.138:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      }
    }
}, {
    caps: ["eth/67", "eth/68", "snap/1"],
    enode: "enode://9e9492e2e8836114cc75f5b929784f4f46c324ad01daf87d956f98b3b6c5fcba95524d6e5cf9861dc96a2c8a171ea7105bb554a197455058de185fa870970c7c@138.68.123.152:30303",
    enr: "enr:-KO4QDPqK9HfccJOffoUCfXqVfnA5gehkM3ZoB2Gwc3fq9leafJAdWfu85aoxpV4oFmX73qNRnWOau-cEfLSoUYiW_WGAYsYzhaig2V0aMfGhPf5vAiAgmlkgnY0gmlwhIpEe5iJc2VjcDI1NmsxoQKelJLi6INhFMx19bkpeE9PRsMkrQHa-H2Vb5iztsX8uoRzbmFwwIN0Y3CCdl-DdWRwgnZf",
    id: "21956df73984224e0e9eaf23adc4917813f08bd50be12a91dcfd6664f953e85a",
    name: "Geth/v1.13.5-stable-916d6a44/linux-amd64/go1.21.4",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:58154",
      remoteAddress: "138.68.123.152:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      },
      snap: {
        version: 1
      }
    }
}, {
    caps: ["eth/66", "eth/67", "eth/68", "snap/1"],
    enode: "enode://cd5af62199a612f15d58bcca01b931b1bfca370ba99466fc7730136c6a7f6ed861000e230cba1e5ea965f6825a65ddbf9d60cf191185c4e75c23f59b9ddf4494@184.174.36.132:50303",
    id: "2a80438a2c766ed4f971ae66e28a5ac87de6a09dff74f0bb10c90110f3225724",
    name: "Geth/v1.12.2-stable-bed84606/linux-amd64/go1.20.7",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:58220",
      remoteAddress: "184.174.36.132:50303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      },
      snap: {
        version: 1
      }
    }
}, {
    caps: ["eth/66", "eth/67", "snap/1"],
    enode: "enode://0d9fa75aa8d0f389dc82b22bdce946eb418087f9b6bdf67532b3ba22da0358fd6e0cb2f23faf60f0956920a0b3318afd20ff85fccb718151c3935dbe9d9f324a@5.188.137.138:30303",
    enr: "enr:-Ka4QOT0ZLvcrMfyy1zgAooUq-qCAvoLJ1kzp3UhXK_0G12KF3tcX_8BJm8p0ZkEqIZg68H1VhS5G_4MMXfn1ebWSrKGAYU6muJEg2V0aMrJhP4zZueDGnrLgmlkgnY0gmlwhAW8iYqJc2VjcDI1NmsxoQINn6daqNDzidyCsivc6UbrQYCH-ba99nUys7oi2gNY_YRzbmFwwIN0Y3CCdl-DdWRwgnZf",
    id: "2d3e535c1baad38b2387a124bee1009b4f18435714371b63740fb9d7000e241a",
    name: "Geth/v1.10.26-stable-e5eb32ac/linux-amd64/go1.18.5",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:33372",
      remoteAddress: "5.188.137.138:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 67
      },
      snap: {
        version: 1
      }
    }
}, {
    caps: ["eth/66", "eth/67", "eth/68", "snap/1"],
    enode: "enode://c4ff6466abf20d2df98276cadc4d3d5df599423d9944efbe5c52dc30cbe5366891b0ac218d9925e8b36f48b39fbf28dfa7e0cd67bc2df39439d9ba116e118e64@161.97.172.13:50303",
    id: "3631ce784ccbe0098b8e624f1b00ff28fa614580472b22edbb9788fc687033f4",
    name: "Geth/v1.12.2-stable-bed84606/linux-amd64/go1.20.7",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:58730",
      remoteAddress: "161.97.172.13:50303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      },
      snap: {
        version: 1
      }
    }
}, {
    caps: ["eth/67", "eth/68", "snap/1"],
    enode: "enode://143e11fb766781d22d92a2e33f8f104cddae4411a122295ed1fdb6638de96a6ce65f5b7c964ba3763bba27961738fef7d3ecc739268f3e5e771fb4c87b6234ba@146.190.1.103:30303",
    id: "8c3148ab1c5ea102b9f044345898d8b0b08b1be17feb63196fd440ca14ccc1bd",
    name: "Geth/v1.13.5-stable-916d6a44/linux-amd64/go1.21.4",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:35168",
      remoteAddress: "146.190.1.103:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      },
      snap: {
        version: 1
      }
    }
}, {
    caps: ["eth/66", "eth/67", "eth/68", "snap/1"],
    enode: "enode://2a4f3611d8ebf523082150981c04f2d00ff3f64e661326c2323e7b80fe742566238f33c1f845cbb4ce703bcda2fe5d3988ad6c41b098e56afca7284de63b7a37@161.97.120.4:50303",
    id: "a4df4d1e796105dcdfb1ee7ebffdf0159d3ad3d27cf44bdd3a64b851b59277c4",
    name: "Geth/v1.12.2-stable-bed84606/linux-amd64/go1.20.7",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:47626",
      remoteAddress: "161.97.120.4:50303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      },
      snap: {
        version: 1
      }
    }
}, {
    caps: ["eth/68"],
    enode: "enode://a9502bf8a83718746f3767423a21291c7c7a367fd2beeccfc2ce9837a90183d9c21f70ad7071b79913f0d49bc1bb6beca59ef78ec7d1accd4fdd30ed9f5c4472@54.167.241.51:30303",
    id: "e05809c88ecc25ef5c1395b7c6da66b7b46bc11bda8de1e8b4748d74ea193dfc",
    name: "erigon/v2.52.5/linux-amd64/go1.20.7",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:37154",
      remoteAddress: "54.167.241.51:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      }
    }
}, {
    caps: ["eth/67", "eth/68", "snap/1"],
    enode: "enode://10d62eff032205fcef19497f35ca8477bea0eadfff6d769a147e895d8b2b8f8ae6341630c645c30f5df6e67547c03494ced3d9c5764e8622a26587b083b028e8@139.59.49.206:30303",
    enr: "enr:-KO4QEJNeBtYNIttH85vzhkZjr5nRw4eIwJ-xerUzB0nzRbJZ1YkEEtvs4ey4gpgbRKzDYI0wsBlUWSECbFrRAQ7AiCGAYsYzhe3g2V0aMfGhPf5vAiAgmlkgnY0gmlwhIs7Mc6Jc2VjcDI1NmsxoQIQ1i7_AyIF_O8ZSX81yoR3vqDq3_9tdpoUfoldiyuPioRzbmFwwIN0Y3CCdl-DdWRwgnZf",
    id: "f9a3a33f455d1acb15cf1d6c13189c964530d165a92cbf6452655de7e8736afe",
    name: "Geth/v1.13.5-stable-916d6a44/linux-amd64/go1.21.4",
    network: {
      inbound: false,
      localAddress: "172.18.0.2:54522",
      remoteAddress: "139.59.49.206:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      },
      snap: {
        version: 1
      }
    }
}]
```

docker composeで立ち上げたコンテナを停止させる。

```bash
docker compose down
```

再起動

```bash
docker compose restart
```

コンテナのログを確認する方法

```bash
docker compose logs --tail=5 
```

### 参考文献
1. [Eth Docker Docs](https://eth-docker.net/)
2. [ethereum/client-go](https://hub.docker.com/r/ethereum/client-go/tags)
3. [How to set up an Ethereum Node with Light Mode using Docker](https://www.willianantunes.com/blog/2021/12/how-to-set-up-an-ethereum-node-with-light-mode-using-docker/)
4. [go-ethereum Docs](https://geth.ethereum.org/docs/getting-started/installing-geth#docker-container)
5. [Dockerを使ってGethをプライベートネットワークで実行してみる](https://zenn.dev/hid3/articles/5533d50b1d3de8)
6. [gethコマンド まとめ](https://zenn.dev/endo/articles/a8d22d9b243caf2f1134)
7. [Ethereumでのスマートコントラクト開発](https://zenn.dev/aki030402/articles/d3123c25f3ed7f)
8. [Geth, SolidityでHello,World](https://zenn.dev/hid3/articles/f81e6c78c09df7)
9. [ブロックチェーン開発メモ ～Ethereum2.0 ネットワーク同期編～](https://zenn.dev/flesvelka/articles/081b93109d572d)
10. [ブロックチェーン開発メモ ～Ethereum2.0 環境構築編～](https://zenn.dev/flesvelka/articles/18ff684393a8da)
11. [Gethをインストールする](https://book.ethereum-jp.net/first_use/installing_geth)
12. [GOデベロッパーのためのイーサリアム](https://ethereum.org/ja/developers/docs/programming-languages/golang/)
13. [GitHub - go-ethereum](https://github.com/ethereum/go-ethereum)
14. [go-ethereumを用いて作成したTransactionをEthereumネットワークに送る方法](https://qiita.com/wh1teB0x/items/81c1aa46ecc5f04391a8)
15. [【GitHub - geth-docker】](https://github.com/islishude/geth-docker/tree/main)
16. [業務でDocker Composeを使うことになった人のためのマニュアル。](https://zenn.dev/fagai/articles/55c1b34172ca5a0bce09)