import {
    useContract,
    useContractRead,
    useContractWrite,
  } from "@thirdweb-dev/react";
  
  function Home() {
    const { contract } = useContract("0x8c7A265C1C40F65A6F924207fa859da29b581c2B");
    const { data: name, isLoading: loadingName } = useContractRead(
        contract,
        "name", // The name of the view/mapping/variable on your contract
      );

      console.log("test")
    // const { mutate: setName, isLoading: settingName } = useContractWrite(
    //   contract,
    //   "setName", // The name of the function on your contract
    // );
  }
  export default Home;