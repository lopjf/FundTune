import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Landing from './components/Landing';
import Nav from './components/Nav';

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Nav />
        <Routes>
          <Route path="/" element={<Landing />} />
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
