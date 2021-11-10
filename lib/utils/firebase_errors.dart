String getErrorString(String code) {
  switch (code) {
    case 'weak-password':
      return 'A senha deve ter 6 caracteres ou mais';
    case 'invalid-email':
      return 'O endereço de e-mail está mal formatado';
    case 'email-already-in-use':
      return 'O endereço de e-mail já está em uso por outra conta';
    case 'invalid-credential':
      return 'A credencial automática fornecida está mal formatada ou expirou';
    case 'wrong-password':
      return 'A senha é inválida ou o usuário não tem uma senha';
    case 'user-not-found':
      return 'Não há nenhum registo de usuário correspondente a este identificador. O usuário pode ter sido excluído';
    case 'user-disabled':
      return 'A conta do usuário foi desabilitada por um administrador';
    case 'too-many-requests':
      return 'Bloqueamos todas as solicitações deste dispositivo devido a atividade incomum. Tente novamente mais tarde';
    case 'operation-not-allowed':
      return 'O provedor fornecido está desabilitado para este projeto';
    case 'user-mismatch':
      return 'As credenciais fornecidas não correspondem ao usuário previamente cadastrado';
    case 'credential-already-in-use':
      return 'Esta credencial já está associada a uma conta de usuário diferente';
    default:
      return 'Um erro indefinido ocorreu!';
  }
}
