import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Landing from './components/Landing';
import Nav from './components/Nav';
import Live from './components/Live';

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Nav />
        <Routes>
          <Route path="/" element={<Landing />} />
          <Route path="live" element={<Live />} />
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
